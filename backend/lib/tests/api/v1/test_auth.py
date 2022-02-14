#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L2_app.api.v1.auth import router
from lib.L2_app.settings import settings
from lib.tests.models.utils_user import tmp_user

_auth_api_path = f"{settings.API_PATH}{router.prefix}"


def test_get_token(client: TestClient):
    password = "pass"
    with tmp_user(password=password) as user:
        r = client.post(
            f"{_auth_api_path}/token",
            data={"username": user.email, "password": password},
        )
        tokens = r.json()
        assert r.status_code == 200
        assert "access_token" in tokens and tokens["access_token"]


def test_get_token_403(client: TestClient):
    password = "pass"
    with tmp_user(password=password, is_active=False) as user:
        r1 = client.post(
            f"{_auth_api_path}/token",
            data={"username": user.email, "password": "wrong_password"},
        )
        assert r1.json()["detail"] == "Incorrect username or password"

        r2 = client.post(
            f"{_auth_api_path}/token",
            data={"username": "user@email.com", "password": "wrong_password"},
        )
        assert r2.json()["detail"] == "Incorrect username or password"

        r3 = client.post(
            f"{_auth_api_path}/token",
            data={"username": user.email, "password": password},
        )
        assert r3.json()["detail"] == "Inactive user"

        assert r1.status_code == r2.status_code == r3.status_code == 403
