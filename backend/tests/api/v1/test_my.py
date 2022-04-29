#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient

from lib.L1_domain.entities import User
from lib.L2_data.mappers import UserMapper
from lib.L2_data.repositories.security_repo import SecurityRepo
from lib.L2_data.schema import UserSchemaGet
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.auth.my import router

_auth_api_path = f"{settings.API_PATH}{router.prefix}"


def _user_from_json(json: dict) -> User:
    return UserMapper().entity_from_schema_get(UserSchemaGet(**json))


def _user_from_orm(obj: any) -> User:
    return UserMapper().entity_from_orm(obj)


def test_get_my_account(client: TestClient, auth_headers_tmp_user, tmp_user):
    r = client.get(f"{_auth_api_path}/account", headers=auth_headers_tmp_user)
    assert r.status_code == 200
    user_out = _user_from_json(r.json())
    assert user_out == _user_from_orm(tmp_user)


def test_update_my_account(client: TestClient, auth_headers_tmp_user):

    full_name: str = "Тестовый пользователь"
    new_password: str = "p1"

    r = client.put(
        f"{_auth_api_path}/account",
        headers=auth_headers_tmp_user,
        json={"full_name": full_name, "password": new_password},
    )
    assert r.status_code == 200

    user_out = _user_from_json(r.json())
    assert SecurityRepo.verify_password(new_password, user_out.password)
    assert user_out.full_name == full_name


def test_resource_403(client: TestClient):

    # hackers
    r3 = client.get(
        f"{_auth_api_path}/account",
        headers={"Authorization": "Bearer HACKERciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDU0ODY5MTEsInzLDh_Xo5qgQ1WvAnB44nlr2Xlano"},
    )
    assert r3.json()["detail"] == "Could not validate credentials", r3.json()
    assert r3.status_code == 403
