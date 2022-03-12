#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from fastapi.testclient import TestClient
from pydantic import EmailStr

from lib.L1_domain.entities import User
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.schema import UserSchema
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.auth import router

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
    assert r.status_code == 200
    assert "access_token" in tokens and tokens["access_token"]


def test_get_token_403(client: TestClient, tmp_user: User, user_repo: UserRepo):
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
    s = UserSchema(id=tmp_user.id, email=EmailStr(tmp_user.email), password=tmp_user.password, is_active=False)
    user_repo.update(jsonable_encoder(s))
    r3 = client.post(
        api_path,
        data={"username": tmp_user.email, "password": "password"},
    )
    assert r3.json()["detail"] == "Inactive user"

    assert r1.status_code == r2.status_code == r3.status_code == 403
