#  Copyright (c) 2022. Alexandr Moroz
from typing import Type

from fastapi.encoders import jsonable_encoder
from sqlalchemy import delete, lambda_stmt, select, update
from sqlalchemy.orm import Session
from sqlalchemy.sql.elements import BinaryExpression

from lib.L1_domain.repositories import AbstractDBRepo, E, M


class DBRepo(AbstractDBRepo[M, E]):
    __abstract__ = True

    def __init__(self, model: Type[M], entity: Type[E], db: Session):
        self.db = db
        super().__init__(model, entity)

    def _prepare_upsert_data(self, e: E) -> any:
        return jsonable_encoder(e)

    def get(
        self,
        *,
        where: BinaryExpression | None = None,
        skip: int = 0,
        limit: int | None = None,
        **filter_by,
    ) -> list[E]:

        model = self.model
        stmt = lambda_stmt(lambda: select(model))

        if where is not None:
            stmt += lambda s: s.where(where)

        stmt = stmt.filter_by(**filter_by).offset(skip)
        if limit is not None:
            stmt = stmt.limit(limit)

        objects = self.db.execute(stmt).scalars().all()
        return [self.entity.from_orm(obj) for obj in objects]

    def create(self, e: E) -> E:
        data = self._prepare_upsert_data(e)
        model = self.model(**data)

        self.db.add(model)
        self.db.commit()
        self.db.refresh(model)
        return self.entity.from_orm(model)

    def update(self, e: E) -> int:
        data = self._prepare_upsert_data(e)
        stmt = update(self.model).where(self.model.id == e.id).values(**data)
        affected_rows = self.db.execute(stmt).rowcount
        self.db.commit()
        return affected_rows

    def delete(self, e: E) -> int:
        stmt = delete(self.model).where(self.model.id == e.id)
        affected_rows = self.db.execute(stmt).rowcount
        self.db.commit()
        return affected_rows
