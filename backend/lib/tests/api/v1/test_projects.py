#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L1_domain.entities.tracker import Project
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.tracker import router
from lib.tests.models.test_project import tmp_object

_projects_api_path = f"{settings.API_PATH}{router.prefix}/projects"


def test_get_projects(client: TestClient, auth_headers_test_user, project_repo):
    with tmp_object(project_repo) as project:
        r = client.get(_projects_api_path, headers=auth_headers_test_user)
        assert r.status_code == 200
        json_projects = r.json()
        projects_out = [Project(**json_project) for json_project in json_projects]
        assert project in projects_out


def test_resource_401(client: TestClient):

    # not auth
    r1 = client.get(_projects_api_path, headers={})
    assert r1.json()["detail"] == "Not authenticated"
    assert r1.status_code == 401
