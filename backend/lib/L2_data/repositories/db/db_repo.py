#  Copyright (c) 2022. Alexandr Moroz
from typing import Type, TypeVar

from fastapi.encoders import jsonable_encoder
from pydantic import BaseModel as BaseSchemaModel
from sqlalchemy import delete, lambda_stmt, select
from sqlalchemy.orm import Session
from sqlalchemy.sql.elements import BinaryExpression

from lib.L1_domain.repositories.abstract_db_repo import AbstractDBRepo, E
from lib.L2_data.models import BaseModel as BaseDBModel

M = TypeVar("M", bound=BaseDBModel)
SGet = TypeVar("SGet", bound=BaseSchemaModel)
SCreate = TypeVar("SCreate", bound=BaseSchemaModel)


class DBRepo(AbstractDBRepo):
    def __init__(
        self,
        model_class: Type[M],
        schema_get_class: Type[SGet],
        schema_create_class: Type[SCreate],
        entity_class: Type[E],
        db: Session,
    ):
        self.db = db
        super().__init__(model_class, schema_get_class, schema_create_class, entity_class)

    def _entity_from_orm(self, db_obj: M) -> E:
        schema_obj = self._schema_get_class.from_orm(db_obj)
        return schema_obj.entity()

    def schema_from_entity(self, e: E) -> SGet:
        return self._schema_create_class(**jsonable_encoder(e))

    def get(
        self,
        *,
        where: BinaryExpression | None = None,
        skip: int = 0,
        limit: int | None = None,
        **filter_by,
    ) -> list[E]:

        model_class = self._model_class
        stmt = lambda_stmt(lambda: select(model_class))

        if where is not None:
            stmt += lambda s: s.where(where)

        stmt = stmt.filter_by(**filter_by).offset(skip)
        if limit is not None:
            stmt = stmt.limit(limit)

        objects = self.db.execute(stmt).scalars().all()
        return [self._entity_from_orm(db_obj) for db_obj in objects]

    def create(self, s: SCreate) -> E:
        data = jsonable_encoder(s)
        db_obj = self._model_class(**data)

        self.db.add(db_obj)
        self.db.commit()
        self.db.refresh(db_obj)

        return self._entity_from_orm(db_obj)

    def update(self, s: SCreate) -> E:
        data = jsonable_encoder(s)
        obj = self.db.merge(self._model_class(**data))
        self.db.commit()

        return self._entity_from_orm(obj)

    def delete(self, pk_id: int) -> int:
        stmt = delete(self._model_class).where(self._model_class.id == pk_id)
        affected_rows = self.db.execute(stmt).rowcount
        if affected_rows:
            self.db.commit()
            return affected_rows
