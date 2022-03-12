#  Copyright (c) 2022. Alexandr Moroz
from typing import Type, TypeVar

from sqlalchemy import delete, lambda_stmt, select
from sqlalchemy.orm import Session
from sqlalchemy.sql.elements import BinaryExpression

from lib.L1_domain.repositories import AbstractDBRepo
from lib.L2_data.models import BaseModel as BaseDBModel

M = TypeVar("M", bound=BaseDBModel)


class DBRepo(AbstractDBRepo[M]):
    def __init__(self, *, model_cls: Type[M], db: Session):
        self._db = db
        super().__init__(model_cls=model_cls)

    def get(
        self,
        *,
        where: BinaryExpression | None = None,
        skip: int = 0,
        limit: int | None = None,
        **filter_by,
    ) -> list[M]:

        model_class = self._model_class
        stmt = lambda_stmt(lambda: select(model_class))

        if where is not None:
            stmt += lambda s: s.where(where)

        stmt = stmt.filter_by(**filter_by).offset(skip)
        if limit is not None:
            stmt = stmt.limit(limit)

        return self._db.execute(stmt).scalars().all()

    def create(self, data: dict) -> M:
        db_obj = self._model_class(**data)

        self._db.add(db_obj)
        self._db.commit()
        self._db.refresh(db_obj)

        return db_obj

    def update(self, data: dict) -> M:
        db_obj = self._db.merge(self._model_class(**data))
        self._db.commit()

        return db_obj

    def delete(self, pk_id: int) -> int:
        stmt = delete(self._model_class).where(self._model_class.id == pk_id)
        affected_rows = self._db.execute(stmt).rowcount
        if affected_rows:
            self._db.commit()
            return affected_rows
