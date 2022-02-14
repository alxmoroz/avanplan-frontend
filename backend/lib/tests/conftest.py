#  Copyright (c) 2022. Alexandr Moroz

from typing import Generator

import pytest
from fastapi.testclient import TestClient

from lib.L1_domain.entities.users import User
from lib.L3_app.settings import settings
from lib.L3_data.repositories import security_repo, user_repo
from lib.main import app


@pytest.fixture(scope="module")
def client() -> Generator:
    with TestClient(app) as c:
        yield c


def _auth_headers_for_user(client: TestClient, email: str, password: str, is_superuser: bool = False):
    user = user_repo.get_one(email=email)
    if not user:
        user_repo.create(
            User(
                email=email,
                password=security_repo.secure_password(password),
                is_superuser=is_superuser,
            ),
        )

    r = client.post(
        f"{settings.API_PATH}/auth/token",
        data={"username": email, "password": password},
    )
    token = r.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}


@pytest.fixture(scope="module")
def auth_headers_test_admin(client: TestClient) -> dict[str, str]:
    return _auth_headers_for_user(
        client,
        settings.TEST_ADMIN_EMAIL,
        settings.TEST_ADMIN_PASSWORD,
        is_superuser=True,
    )


@pytest.fixture(scope="module")
def auth_headers_test_user(client: TestClient) -> dict[str, str]:
    return _auth_headers_for_user(
        client,
        settings.TEST_USER_EMAIL,
        settings.TEST_USER_PASSWORD,
    )
