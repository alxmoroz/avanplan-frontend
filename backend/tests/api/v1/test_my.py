#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from fastapi.testclient import TestClient
from pydantic import EmailStr

from lib.L1_domain.entities import User
from lib.L2_data.mappers import UserMapper
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.repositories.security_repo import SecurityRepo
from lib.L2_data.schema import UserSchemaGet, UserSchemaUpsert
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.auth.my import router
from tests.conf_auth import TEST_USER_EMAIL, auth_headers_for_user

_auth_api_path = f"{settings.API_PATH}{router.prefix}"


def _user_from_json(json: dict) -> User:
    return UserMapper().entity_from_schema_get(UserSchemaGet(**json))


def _user_from_orm(obj: any) -> User:
    return UserMapper().entity_from_orm(obj)


def test_get_my_account(client: TestClient, auth_headers_test_user, user_repo):
    r = client.get(f"{_auth_api_path}/account", headers=auth_headers_test_user)
    assert r.status_code == 200
    user_out = _user_from_json(r.json())
    test_user = _user_from_orm(user_repo.get_one(email=TEST_USER_EMAIL))
    assert user_out
    assert user_out and user_out == test_user


def test_update_my_account(client: TestClient, auth_headers_test_user, user_repo):

    full_name: str = "Тестовый пользователь"
    new_password: str = "p1"

    r = client.put(
        f"{_auth_api_path}/account",
        headers=auth_headers_test_user,
        json={"full_name": full_name, "password": new_password},
    )
    assert r.status_code == 200

    user_out = _user_from_json(r.json())
    test_user = _user_from_orm(user_repo.get_one(email=TEST_USER_EMAIL))

    assert SecurityRepo.verify_password(new_password, test_user.password)
    assert SecurityRepo.verify_password(new_password, user_out.password)

    assert user_out and test_user and user_out == test_user
    assert test_user.full_name == full_name


def test_resource_403(client: TestClient, user_repo: UserRepo):

    # not exists
    s = UserSchemaUpsert(email=EmailStr("404_user@test.com"), password="pass")
    user_404 = user_repo.upsert(jsonable_encoder(s))
    headers_user_404 = auth_headers_for_user(user_repo, user_404.email)
    user_repo.delete(user_404.id)

    r2 = client.get(f"{_auth_api_path}/account", headers=headers_user_404)
    assert r2.json()["detail"] == "User is not found", r2.json()
    assert r2.status_code == 404

    # hackers
    r3 = client.get(
        f"{_auth_api_path}/account",
        headers={"Authorization": "Bearer HACKERciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDU0ODY5MTEsInzLDh_Xo5qgQ1WvAnB44nlr2Xlano"},
    )
    assert r3.json()["detail"] == "Could not validate credentials", r3.json()
    assert r3.status_code == 403
