#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L2_data.settings import settings
from lib.L3_app.api.v1.import_redmine import router

_import_redmine_api_path = f"{settings.API_PATH}{router.prefix}"


def test_import(client: TestClient, auth_headers_test_user):

    # TODO: 1951 нельзя привязываться к конкретному редмайну и оставлять тут креды для доступа к нему?
    host = "https://redmine.moroz.team"
    api_key = "101b62ea94b4132625a3d079451ea13fed3f4b87"
    api_path = f"{_import_redmine_api_path}/tasks"

    r = client.post(
        api_path,
        json={"host": host, "api_key": api_key},
        headers=auth_headers_test_user,
    )
    # TODO: проверить, что в базу запись прошла тут или в тестах моделей?
    assert r.status_code == 200
    assert r.json()["msg"] == f"Projects and tasks from Redmine {host} imported successful"

    # 400
    r2 = client.post(
        api_path,
        json={"host": host},
        headers=auth_headers_test_user,
    )
    r3 = client.post(
        api_path,
        json={"api_key": api_key},
        headers=auth_headers_test_user,
    )
    assert r2.status_code == r3.status_code == 400
