#  Copyright (c) 2022. Alexandr Moroz

from pydantic import PostgresDsn
from sqlalchemy.future import create_engine
from sqlalchemy.orm import sessionmaker


def db_name_from_org(org_name) -> str:
    return f"h_org_{org_name}"


def db_user_from_org(org_name) -> str:
    return f"h_{org_name}"


def db_password_from_org(org_name) -> str:
    return f"h_{org_name}"


def _pg_url_from_org_name(org_name):
    return PostgresDsn.build(
        scheme="postgresql",
        user=db_user_from_org(org_name),
        password=db_password_from_org(org_name),
        host="localhost",
        path=f"/{db_name_from_org(org_name)}",
    )


def session_maker_for_org(org_name):
    _engine = create_engine(_pg_url_from_org_name(org_name), pool_pre_ping=True, future=True)
    return sessionmaker(bind=_engine, future=True)
