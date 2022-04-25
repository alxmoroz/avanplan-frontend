#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from fastapi.testclient import TestClient
from pydantic import EmailStr

from lib.L1_domain.entities import User
from lib.L2_data.mappers import UserMapper
from lib.L2_data.models_auth import Organization
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.repositories.security_repo import SecurityRepo
from lib.L2_data.schema import UserSchemaGet, UserSchemaUpsert
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.auth import router
from tests.conf_auth import TEST_USER_EMAIL, auth_headers_for_user
from tests.utils import random_email

_auth_api_path = f"{settings.API_PATH}{router.prefix}"


# TODO: на фронте генерятся заглушки для всех нужных тестов. Возможно, стоит апи тестить там сразу.
#  По сути е2е тест получится и это лучше
#  данные тестовые записывать тоже по апи оттуда. На бэке достаточно держать только админа.


def test_get_token(client: TestClient, tmp_user):

    r = client.post(
        f"{_auth_api_path}/token",
        data={"username": tmp_user.email, "password": "password"},
    )
    tokens = r.json()
    assert r.status_code == 200, r.json()
    assert "access_token" in tokens and tokens["access_token"]


def test_get_token_403(client: TestClient, tmp_user: User, user_repo: UserRepo, tmp_org: Organization):
    api_path = f"{_auth_api_path}/token"
    r1 = client.post(
        api_path,
        data={"username": tmp_user.email, "password": "wrong_password"},
    )
    assert r1.json()["detail"] == "Incorrect username or password"

    r2 = client.post(
        api_path,
        data={"username": "user@email.com", "password": "wrong_password"},
    )
    assert r2.json()["detail"] == "Incorrect username or password"
    s = UserSchemaUpsert(id=tmp_user.id, email=EmailStr(tmp_user.email), password=tmp_user.password, is_active=False, organization_id=tmp_org.id)
    user_repo.upsert(jsonable_encoder(s))
    r3 = client.post(
        api_path,
        data={"username": tmp_user.email, "password": "password"},
    )
    assert r3.json()["detail"] == "Inactive user"

    assert r1.status_code == r2.status_code == r3.status_code == 403


def _user_from_json(json: dict) -> User:
    return UserMapper().entity_from_schema_get(UserSchemaGet(**json))


def _user_from_orm(obj: any) -> User:
    return UserMapper().entity_from_orm(obj)


def test_get_users(client: TestClient, auth_headers_test_admin, tmp_user: User):
    r = client.get(f"{_auth_api_path}/users", headers=auth_headers_test_admin)
    assert r.status_code == 200
    json_users = r.json()

    users_out = [_user_from_json(json_user) for json_user in json_users]
    assert _user_from_orm(tmp_user) in users_out


def test_get_my_account_admin(client: TestClient, auth_headers_test_admin, user_repo):
    r = client.get(f"{_auth_api_path}/my/account", headers=auth_headers_test_admin)
    assert r.status_code == 200
    user_out = _user_from_json(r.json())

    admin_user = _user_from_orm(user_repo.get_one(email=settings.DEFAULT_ADMIN_EMAIL))

    assert user_out and user_out == admin_user


def test_get_my_account(client: TestClient, auth_headers_test_user, user_repo):
    r = client.get(f"{_auth_api_path}/my/account", headers=auth_headers_test_user)
    assert r.status_code == 200
    user_out = _user_from_json(r.json())
    test_user = _user_from_orm(user_repo.get_one(email=TEST_USER_EMAIL))
    assert user_out
    assert user_out and user_out == test_user


def test_update_my_account(client: TestClient, auth_headers_test_user, user_repo):

    full_name: str = "Тестовый пользователь"
    new_password: str = "p1"

    r = client.put(
        f"{_auth_api_path}/my/account",
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


def test_create_user(client: TestClient, auth_headers_test_admin, user_repo: UserRepo, tmp_org: Organization):
    email = random_email()
    data = {"email": email, "password": "password", "organization_id": tmp_org.id}
    r = client.post(
        f"{_auth_api_path}/users",
        headers=auth_headers_test_admin,
        json=data,
    )
    assert r.status_code == 201
    user_out = _user_from_json(r.json())
    user_out2 = _user_from_orm(user_repo.get_one(email=email))
    assert user_out and user_out2 and user_out == user_out2
    user_repo.delete(user_out.id)


def test_create_user_existing_email(client: TestClient, auth_headers_test_admin, tmp_user: User, tmp_org: Organization):
    data = {"email": tmp_user.email, "password": tmp_user.password, "organization_id": tmp_org.id}
    r = client.post(
        f"{_auth_api_path}/users",
        headers=auth_headers_test_admin,
        json=data,
    )
    user_out = r.json()
    assert r.status_code == 400
    assert "email" not in user_out


def test_resource_403(client: TestClient, auth_headers_test_user, user_repo: UserRepo, tmp_org: Organization):

    # not admin
    r1 = client.get(f"{_auth_api_path}/users", headers=auth_headers_test_user)
    assert r1.json()["detail"] == "The user doesn't have enough privileges"
    assert r1.status_code == 403
    s = UserSchemaUpsert(email=EmailStr("inactive_user@test.com"), password="pass", is_active=False, organization_id=tmp_org.id)
    inactive_user = user_repo.upsert(jsonable_encoder(s))
    a_headers_inactive_user = auth_headers_for_user(user_repo, tmp_org, inactive_user.email)
    # not active
    r2 = client.get(f"{_auth_api_path}/users", headers=a_headers_inactive_user)
    assert r2.json()["detail"] == "Inactive user"
    assert r2.status_code == 403
    user_repo.delete(inactive_user.id)

    # not exists
    r3 = client.get(f"{_auth_api_path}/users", headers=a_headers_inactive_user)
    assert r3.json()["detail"] == "User not found"
    assert r3.status_code == 404

    # hackers
    r4 = client.get(
        f"{_auth_api_path}/users",
        headers={"Authorization": "Bearer HACKERciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDU0ODY5MTEsInzLDh_Xo5qgQ1WvAnB44nlr2Xlano"},
    )
    assert r4.json()["detail"] == "Could not validate credentials"
    assert r4.status_code == 403
