#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from lib.extra.config import settings
from lib.L3_data import crud
from lib.L3_data.schemas.user import UserCreate
from lib.tests.utils.user import random_email, random_lower_string


def test_get_my_account_admin(client: TestClient, token_headers_admin) -> None:
    r = client.get(f"{settings.API_PATH}/users/my/account", headers=token_headers_admin)
    print(token_headers_admin)
    assert r.status_code == 200
    current_user = r.json()
    assert current_user
    assert current_user["is_active"] is True
    assert current_user["is_superuser"]
    assert current_user["email"] == settings.FIRST_SUPERUSER_EMAIL


def test_get_my_account(client: TestClient, token_headers_user) -> None:
    r = client.get(f"{settings.API_PATH}/users/my/account", headers=token_headers_user)
    assert r.status_code == 200
    current_user = r.json()
    assert current_user
    assert current_user["is_active"] is True
    assert current_user["is_superuser"] is False
    assert current_user["email"] == settings.TEST_USER_EMAIL


def test_create_user_new_email(
    client: TestClient, token_headers_admin, db: Session
) -> None:
    username = random_email()
    password = random_lower_string()
    data = {"email": username, "password": password}
    r = client.post(
        f"{settings.API_PATH}/users/", headers=token_headers_admin, json=data
    )
    assert r.status_code == 201
    created_user = r.json()
    user = crud.user.get_by_email(db, email=username)
    assert user
    assert user.email == created_user["email"]


# def test_get_existing_user(
#     client: TestClient, token_headers_admin, db: Session
# ) -> None:
#     username = random_email()
#     password = random_lower_string()
#     user_in = UserCreate(email=username, password=password)
#     user = crud.user.create(db, obj_in=user_in)
#     user_id = user.id
#     r = client.get(
#         f"{settings.API_V_STR}/users/{user_id}",
#         headers=token_headers_admin
#     )
#     assert r.status_code == 200
#     api_user = r.json()
#     existing_user = crud.user.get_by_email(db, email=username)
#     assert existing_user
#     assert existing_user.email == api_user["email"]


def test_create_user_existing_username(
    client: TestClient, token_headers_admin, db: Session
) -> None:
    username = random_email()
    # username = email
    password = random_lower_string()
    user_in = UserCreate(email=username, password=password)
    crud.user.create(db, obj_in=user_in)
    data = {"email": username, "password": password}
    r = client.post(
        f"{settings.API_PATH}/users/",
        headers=token_headers_admin,
        json=data,
    )
    created_user = r.json()
    assert r.status_code == 400
    assert "_id" not in created_user


def test_retrieve_users(client: TestClient, token_headers_admin, db: Session) -> None:
    username = random_email()
    password = random_lower_string()
    user_in = UserCreate(email=username, password=password)
    crud.user.create(db, obj_in=user_in)

    username2 = random_email()
    password2 = random_lower_string()
    user_in2 = UserCreate(email=username2, password=password2)
    crud.user.create(db, obj_in=user_in2)

    r = client.get(f"{settings.API_PATH}/users/", headers=token_headers_admin)
    all_users = r.json()

    assert len(all_users) > 3
    for u in all_users:
        assert "email" in u
