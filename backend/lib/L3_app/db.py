#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.future import create_engine
from sqlalchemy.orm import Session, sessionmaker

from .settings import settings

_engine = create_engine(settings.SQLALCHEMY_DATABASE_URI, pool_pre_ping=True, future=True)
DBSession = sessionmaker(bind=_engine, future=True)


def db_session() -> Session:
    session = None
    try:
        session = DBSession()
        yield session
    finally:
        session.close()
