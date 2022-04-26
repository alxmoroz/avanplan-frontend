#  Copyright (c) 2022. Alexandr Moroz

from pydantic import PostgresDsn
from sqlalchemy.future import create_engine
from sqlalchemy.orm import Session, sessionmaker


def db_user_for_db(db_name) -> str:
    return f"h_{db_name}"


def db_password_for_db(db_name) -> str:
    return f"h_{db_name}"


def pg_dsn_url(db_name):
    return PostgresDsn.build(
        scheme="postgresql",
        user=db_user_for_db(db_name),
        password=db_password_for_db(db_name),
        host="localhost",
        path=f"/{db_name}",
    )


def session_maker_for_db(db_name):
    _engine = create_engine(pg_dsn_url(db_name), pool_pre_ping=True, future=True)
    return sessionmaker(bind=_engine, future=True)


def db_session() -> Session:
    session: Session | None = None
    try:
        session = session_maker_for_db("hercules")()
        yield session
    finally:
        session.close()
