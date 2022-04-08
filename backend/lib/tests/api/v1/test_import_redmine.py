#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L2_data.settings import settings
from lib.L3_app.api.v1.integrations.routers import integrations_router, redmine_router

# TODO: 1951 нельзя привязываться к конкретному редмайну и оставлять тут креды для доступа к нему
#  апи тестируем на фронте...

_host = "https://redmine.moroz.team"
_api_key = "101b62ea94b4132625a3d079451ea13fed3f4b87"
_api_path = f"{settings.API_PATH}{integrations_router.prefix}{redmine_router.prefix}"


def _request(client: TestClient, auth_headers_test_user, path):
    print(_api_path)
    return client.post(
        f"{_api_path}/{path}",
        json={"host": _host, "api_key": _api_key},
        headers=auth_headers_test_user,
    )


def test_import_goals(client: TestClient, auth_headers_test_user):
    r = _request(client, auth_headers_test_user, "goals")
    assert r.status_code == 200, r.json()["detail"]
    assert r.json()["msg"] == f"Goals from Redmine {_host} imported successful"

    # 400 (no api_key)
    r2 = client.post(
        r.request.path_url,
        json={"host": _host},
        headers=auth_headers_test_user,
    )

    # 400 (no host)
    r3 = client.post(
        r.request.path_url,
        json={"api_key": _api_key},
        headers=auth_headers_test_user,
    )
    assert r2.status_code == r3.status_code == 400


# def test_import_tasks(client: TestClient, auth_headers_test_user):
#     r = _request(client, auth_headers_test_user, "tasks")
#     assert r.status_code == 200, r.json()["detail"]
#     assert r.json()["msg"] == f"Tasks with goals from Redmine {_host} imported successful"
