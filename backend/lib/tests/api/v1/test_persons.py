#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L1_domain.entities.tracker import Person
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.tracker import router
from lib.tests.models.test_person import tmp_object

_persons_api_path = f"{settings.API_PATH}{router.prefix}/persons"


def test_get_persons(client: TestClient, auth_headers_test_user, person_repo):
    with tmp_object(person_repo) as person:
        r = client.get(_persons_api_path, headers=auth_headers_test_user)
        assert r.status_code == 200
        json_persons = r.json()
        persons_out = [Person(**json_person) for json_person in json_persons]
        assert person in persons_out


def test_resource_401(client: TestClient):

    # not auth
    r1 = client.get(_persons_api_path, headers={})
    assert r1.json()["detail"] == "Not authenticated"
    assert r1.status_code == 401
