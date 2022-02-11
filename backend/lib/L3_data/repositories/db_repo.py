#  Copyright (c) 2022. Alexandr Moroz

from contextlib import contextmanager
from typing import Generator, Generic, Type, TypeVar

from fastapi.encoders import jsonable_encoder
from sqlalchemy import create_engine, delete, select, update
from sqlalchemy.orm import sessionmaker

from lib.L1_domain.entities.base_entity import BaseEntity
from lib.L2_app.extra.config import settings

from ..models.base_model import BaseModel

DBModelType = TypeVar("DBModelType", bound=BaseModel)
EntityType = TypeVar("EntityType", bound=BaseEntity)

engine = create_engine(
    settings.SQLALCHEMY_DATABASE_URI, pool_pre_ping=True, future=True
)
Session = sessionmaker(bind=engine, future=True)


@contextmanager
def db_session() -> Generator:
    session = None
    try:
        session = Session()
        yield session
    finally:
        session.close()


# TODO: нужен соотв. по интерфейсу репозиторий в Л1
class DBRepo(Generic[DBModelType, EntityType]):
    def __init__(self, model: Type[DBModelType], entity: Type[EntityType]):
        self.model = model
        self.entity = entity

    def get(
        self,
        filter_by: dict,
        limit: int | None = None,
        skip: int = 0,
    ) -> list[EntityType]:
        with db_session() as session:
            stmt = select(self.model).filter_by(**filter_by).offset(skip)
            if limit is not None:
                stmt = stmt.limit(limit)
            objects = session.execute(stmt).scalars().all()

        return [self.entity(**jsonable_encoder(obj)) for obj in objects]

    def create(self, e: EntityType) -> EntityType:
        e_data = jsonable_encoder(e)
        model = self.model(**e_data)
        with db_session() as session:
            session.add(model)
            session.commit()
            # TODO:
            # session.refresh(model)
            e.id = model.id
        return e

    def update(self, e: EntityType) -> int:
        with db_session() as session:
            stmt = update(self.model).where(self.model.id == e.id).values(**e.dict())
            affected_rows = session.execute(stmt).rowcount
            session.commit()
        return affected_rows

    def delete(self, e: EntityType) -> int:
        with db_session() as session:
            stmt = delete(self.model).where(self.model.id == e.id)
            affected_rows = session.execute(stmt).rowcount
            session.commit()
        return affected_rows
