#  Copyright (c) 2022. Alexandr Moroz
from typing import Type

from fastapi.encoders import jsonable_encoder
from sqlalchemy import delete, lambda_stmt, select, update
from sqlalchemy.orm import Session
from sqlalchemy.sql.elements import BinaryExpression

from lib.L1_domain.repositories import AbstractDBRepo, E, M


class DBRepo(AbstractDBRepo[M, E]):
    def __init__(self, model: Type[M], entity: Type[E], db: Session):
        self.db = db
        super().__init__(model, entity)

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

        return [self.entity(**jsonable_encoder(obj)) for obj in objects]

    def create(self, e: E) -> E:
        e_data = jsonable_encoder(e)
        model = self.model(**e_data)

        self.db.add(model)
        self.db.commit()
        e.id = model.id
        return e

    def update(self, e: E) -> int:
        stmt = update(self.model).where(self.model.id == e.id).values(**e.dict())
        affected_rows = self.db.execute(stmt).rowcount
        self.db.commit()
        return affected_rows

    def delete(self, e: E) -> int:
        stmt = delete(self.model).where(self.model.id == e.id)
        affected_rows = self.db.execute(stmt).rowcount
        self.db.commit()
        return affected_rows
