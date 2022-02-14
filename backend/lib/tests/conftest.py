#  Copyright (c) 2022. Alexandr Moroz

from typing import Generator

import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from lib.L1_domain.entities.users import User
from lib.L2_data.db import DBSession
from lib.L2_data.repositories import SecurityRepo, UserRepo
from lib.L2_data.settings import settings
from lib.L3_app.main import app


@pytest.fixture(scope="module")
def client() -> Generator:
    with TestClient(app) as c:
        yield c


def auth_headers_for_user(db: Session, email: str, is_superuser: bool = False):
    repo = UserRepo(db)
    user = repo.get_one(email=email)
    if not user:
        user = repo.create(
            User(
                email=email,
                password=SecurityRepo.secure_password(settings.TEST_ADMIN_PASSWORD if is_superuser else settings.TEST_USER_PASSWORD),
                is_superuser=is_superuser,
            ),
        )

    token = SecurityRepo.create_token(str(user.id)).access_token
    return {"Authorization": f"Bearer {token}"}


@pytest.fixture(scope="session")
def auth_headers_test_admin(db: Session) -> dict[str, str]:
    return auth_headers_for_user(db, settings.TEST_ADMIN_EMAIL, is_superuser=True)


@pytest.fixture(scope="session")
def auth_headers_test_user(db: Session) -> dict[str, str]:
    return auth_headers_for_user(db, settings.TEST_USER_EMAIL)


@pytest.fixture(scope="session")
def db() -> Session:
    session = DBSession()
    yield session
    session.close()
