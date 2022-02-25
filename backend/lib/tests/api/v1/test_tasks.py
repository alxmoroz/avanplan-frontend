#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L1_domain.entities.tracker import Task
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.tracker import router

_tasks_api_path = f"{settings.API_PATH}{router.prefix}/tasks"


def test_get_tasks(client: TestClient, auth_headers_test_user, tmp_task):

    r = client.get(_tasks_api_path, headers=auth_headers_test_user)
    assert r.status_code == 200
    json_tasks = r.json()
    tasks_out = [Task(**json_task) for json_task in json_tasks]
    assert tmp_task in tasks_out


def test_resource_401(client: TestClient):

    # not auth
    r1 = client.get(_tasks_api_path, headers={})
    assert r1.json()["detail"] == "Not authenticated"
    assert r1.status_code == 401
