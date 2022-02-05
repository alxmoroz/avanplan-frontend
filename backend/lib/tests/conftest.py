from typing import Generator

import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from lib.L3_data.db.session import SessionLocal
from lib.extra.config import settings
from lib.main import app
from .utils.user import auth_headers_from_email, get_superuser_token_headers


@pytest.fixture(scope="session")
def db() -> Generator:
    yield SessionLocal()


@pytest.fixture(scope="module")
def client() -> Generator:
    with TestClient(app) as c:
        yield c


@pytest.fixture(scope="module")
def token_headers_admin(client: TestClient) -> dict[str, str]:
    return get_superuser_token_headers(client)


@pytest.fixture(scope="module")
def token_headers_user(client: TestClient, db: Session) -> dict[str, str]:
    return auth_headers_from_email(client=client, email=settings.TEST_USER_EMAIL, db=db)
