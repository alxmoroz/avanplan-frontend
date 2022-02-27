#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L1_domain.entities.goals import Goal
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.goals import router

_goals_api_path = f"{settings.API_PATH}{router.prefix}"


def test_get_goals(client: TestClient, auth_headers_test_user, tmp_goal):

    r = client.get(_goals_api_path, headers=auth_headers_test_user)
    assert r.status_code == 200, r
    json_goals = r.json()
    goals_out = [Goal(**json_goal) for json_goal in json_goals]
    assert tmp_goal in goals_out


def test_resource_401(client: TestClient):

    # not auth
    r1 = client.get(_goals_api_path, headers={})
    assert r1.json()["detail"] == "Not authenticated"
    assert r1.status_code == 401
