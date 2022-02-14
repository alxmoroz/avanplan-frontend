#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L2_data.settings import settings
from lib.L3_app.api.v1.import_redmine import router

_import_redmine_api_path = f"{settings.API_PATH}{router.prefix}"


def test_import(client: TestClient, auth_headers_test_user):

    # TODO: нельзя привязываться к конкретному редмайну и оставлять тут креды для доступа к нему?
    host = "https://redmine.moroz.team"
    api_key = "101b62ea94b4132625a3d079451ea13fed3f4b87"

    r = client.post(
        f"{_import_redmine_api_path}/tasks",
        json={"host": host, "api_key": api_key},
        headers=auth_headers_test_user,
    )

    assert r.status_code == 200
    assert r.json()["msg"] == f"Projects and tasks from Redmine {host} imported successful"

    # TODO: проверить, что в базу запись прошла тут или в тестах моделей?
