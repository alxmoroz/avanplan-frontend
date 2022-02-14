#  Copyright (c) 2022. Alexandr Moroz
from contextlib import contextmanager
from typing import Generator

from sqlalchemy.future import create_engine
from sqlalchemy.orm import sessionmaker

from .settings import settings

_engine = create_engine(settings.SQLALCHEMY_DATABASE_URI, pool_pre_ping=True, future=True)


# TODO: на каждый запрос к БД новое соединение — это слишком...
@contextmanager
def db_session() -> Generator:
    session = None
    try:
        session = sessionmaker(bind=_engine, future=True)()
        yield session
    finally:
        session.close()
