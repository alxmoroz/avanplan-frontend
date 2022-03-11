#  Copyright (c) 2022. Alexandr Moroz
from typing import Type, TypeVar

from fastapi.encoders import jsonable_encoder
from sqlalchemy import delete, lambda_stmt, select
from sqlalchemy.orm import Session
from sqlalchemy.sql.elements import BinaryExpression

from lib.L1_domain.repositories import AbstractDBRepo, E, ERepo
from lib.L2_data.models import BaseModel as BaseDBModel
from lib.L2_data.repositories.entities import SCreate

M = TypeVar("M", bound=BaseDBModel)


# TODO: подумать над снятием зависимости от Е Для преобразования Е - S есть репа ERepo и можно докрутить туда преобразование из объектов БД.
#  Здесь останется непоср. работа с БД. Тогда не нужно будет инициализировать эту репу репой сущностей. А работать как планировалось, в юзкейсе.


class DBRepo(AbstractDBRepo[M, SCreate, E]):
    def __init__(
        self,
        *,
        model_cls: Type[M],
        entity_repo: ERepo,
        db: Session,
    ):
        self._db = db
        super().__init__(model_cls=model_cls, entity_repo=entity_repo)

    # TODO: перенести в ERepo?
    def _entity_from_orm(self, db_obj: M) -> E:
        schema_obj = self.entity_repo._schema_get_cls.from_orm(db_obj)
        return self.entity_repo.entity_from_schema(schema_obj)

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

        objects = self._db.execute(stmt).scalars().all()
        return [self._entity_from_orm(db_obj) for db_obj in objects]

    def create(self, s: SCreate) -> E:
        data = jsonable_encoder(s)
        db_obj = self._model_class(**data)

        self._db.add(db_obj)
        self._db.commit()
        self._db.refresh(db_obj)

        return self._entity_from_orm(db_obj)

    def update(self, s: SCreate) -> E:
        data = jsonable_encoder(s)
        db_obj = self._db.merge(self._model_class(**data))
        self._db.commit()

        return self._entity_from_orm(db_obj)

    def delete(self, pk_id: int) -> int:
        stmt = delete(self._model_class).where(self._model_class.id == pk_id)
        affected_rows = self._db.execute(stmt).rowcount
        if affected_rows:
            self._db.commit()
            return affected_rows
