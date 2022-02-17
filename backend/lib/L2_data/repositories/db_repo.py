#  Copyright (c) 2022. Alexandr Moroz
from typing import Type

from fastapi.encoders import jsonable_encoder
from sqlalchemy import delete, lambda_stmt, select, update
from sqlalchemy.orm import Session
from sqlalchemy.sql.elements import BinaryExpression

from lib.L1_domain.entities.tracker import Project, Task
from lib.L1_domain.entities.users import User
from lib.L1_domain.repositories import AbstractDBRepo, E, M

from ..models.tracker import Project as ProjectModel
from ..models.tracker import Task as TaskModel
from ..models.users import User as UserModel


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


class UserRepo(DBRepo[UserModel, User]):
    def __init__(self, db: Session):
        super().__init__(UserModel, User, db)


class ProjectRepo(DBRepo[ProjectModel, Project]):
    def __init__(self, db: Session):
        super().__init__(ProjectModel, Project, db)


class TaskRepo(DBRepo[TaskModel, Task]):
    def __init__(self, db: Session):
        super().__init__(TaskModel, Task, db)
