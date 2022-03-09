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
S = TypeVar("S", bound=BaseSchemaModel)


class DBRepo(AbstractDBRepo[M, S, E]):
    def __init__(
        self,
        model_class: Type[M],
        schema_class: Type[S],
        entity_class: Type[E],
        db: Session,
    ):
        self.db = db
        super().__init__(model_class, schema_class, entity_class)

    @staticmethod
    def encode_data(s: S) -> any:
        return jsonable_encoder(s)

    def entity_from_schema(self, s: S) -> E:
        return self.entity_class(**s.dict())

    def _entity_from_orm(self, db_obj: M) -> E:
        schema_obj = self.schema_class.from_orm(db_obj)
        return self.entity_from_schema(schema_obj)

    def get(
        self,
        *,
        where: BinaryExpression | None = None,
        skip: int = 0,
        limit: int | None = None,
        **filter_by,
    ) -> list[E]:

        model_class = self.model_class
        stmt = lambda_stmt(lambda: select(model_class))

        if where is not None:
            stmt += lambda s: s.where(where)

        stmt = stmt.filter_by(**filter_by).offset(skip)
        if limit is not None:
            stmt = stmt.limit(limit)

        objects = self.db.execute(stmt).scalars().all()
        return [self._entity_from_orm(db_obj) for db_obj in objects]

    def create(self, s: S) -> E:
        data = self.encode_data(s)
        db_obj = self.model_class(**data)

        self.db.add(db_obj)
        self.db.commit()
        self.db.refresh(db_obj)

        return self._entity_from_orm(db_obj)

    def update(self, s: S) -> E:
        data = self.encode_data(s)
        obj = self.db.merge(self.model_class(**data))
        self.db.commit()

        return self._entity_from_orm(obj)

    def delete(self, pk_id: int) -> int:
        stmt = delete(self.model_class).where(self.model_class.id == pk_id)
        affected_rows = self.db.execute(stmt).rowcount
        if affected_rows:
            self.db.commit()
            return affected_rows
