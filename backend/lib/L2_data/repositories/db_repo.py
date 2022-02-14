#  Copyright (c) 2022. Alexandr Moroz


from fastapi.encoders import jsonable_encoder
from sqlalchemy import delete, lambda_stmt, select, update
from sqlalchemy.sql.elements import BinaryExpression

from lib.L1_domain.repositories import AbstractDBRepo, E, M
from lib.L3_app.db import db_session


class DBRepo(AbstractDBRepo[M, E]):
    def get(
        self,
        *,
        where: BinaryExpression | None = None,
        limit: int | None = None,
        skip: int = 0,
        **filter_by,
    ) -> list[E]:

        with db_session() as session:
            model = self.model
            stmt = lambda_stmt(lambda: select(model))

            if where is not None:
                stmt += lambda s: s.where(where)

            stmt = stmt.filter_by(**filter_by).offset(skip)
            if limit is not None:
                stmt = stmt.limit(limit)

            objects = session.execute(stmt).scalars().all()

        return [self.entity(**jsonable_encoder(obj)) for obj in objects]

    def create(self, e: E) -> E:
        e_data = jsonable_encoder(e)
        model = self.model(**e_data)
        with db_session() as session:
            session.add(model)
            session.commit()
            e.id = model.id
        return e

    def update(self, e: E) -> int:
        with db_session() as session:
            stmt = update(self.model).where(self.model.id == e.id).values(**e.dict())
            affected_rows = session.execute(stmt).rowcount
            session.commit()
        return affected_rows

    def delete(self, e: E) -> int:
        with db_session() as session:
            stmt = delete(self.model).where(self.model.id == e.id)
            affected_rows = session.execute(stmt).rowcount
            session.commit()
        return affected_rows
