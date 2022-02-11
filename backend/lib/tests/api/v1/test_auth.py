#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L2_app.extra.config import settings


def test_get_token(client: TestClient) -> None:
    login_data = {
        "username": settings.TEST_ADMIN_EMAIL,
        "password": settings.TEST_ADMIN_PASSWORD,
    }
    r = client.post(f"{settings.API_PATH}/auth/token", data=login_data)
    tokens = r.json()
    assert r.status_code == 200
    assert "access_token" in tokens and tokens["access_token"]
