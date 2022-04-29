#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L2_data.settings import settings
from lib.L3_app.api.v1.goals import router

_goals_api_path = f"{settings.API_PATH}{router.prefix}"


def test_resource_401(client: TestClient):

    # not auth
    r1 = client.post(f"{_goals_api_path}/")

    assert r1.status_code == 401
    assert r1.json()["detail"] == "Not authenticated", r1.json()
