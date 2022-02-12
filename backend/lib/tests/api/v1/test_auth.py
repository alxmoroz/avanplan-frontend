#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L2_app.extra.config import settings


def test_get_token(client: TestClient):

    r = client.post(
        f"{settings.API_PATH}/auth/token",
        data={
            "username": settings.TEST_ADMIN_EMAIL,
            "password": settings.TEST_ADMIN_PASSWORD,
        },
    )
    tokens = r.json()
    assert r.status_code == 200
    assert "access_token" in tokens and tokens["access_token"]
