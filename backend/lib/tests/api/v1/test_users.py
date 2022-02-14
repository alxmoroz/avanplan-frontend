#  Copyright (c) 2022. Alexandr Moroz

from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from lib.L1_domain.entities.users.user import User
from lib.L2_data.repositories import SecurityRepo, UserRepo
from lib.L2_data.settings import settings
from lib.L3_app.api.v1.users import router
from lib.tests.models.utils_user import random_email, tmp_user

_users_api_path = f"{settings.API_PATH}{router.prefix}"


def test_get_users(client: TestClient, auth_headers_test_admin, db: Session):
    with tmp_user(db) as user_out:
        r = client.get(f"{_users_api_path}/", headers=auth_headers_test_admin)
        assert r.status_code == 200
        json_users = r.json()
        users_out = [User(**json_user) for json_user in json_users]
        assert user_out in users_out


def test_get_my_account_admin(client: TestClient, auth_headers_test_admin, db: Session):
    r = client.get(f"{_users_api_path}/my/account", headers=auth_headers_test_admin)
    assert r.status_code == 200
    user_out = User(**r.json())
    admin_user = UserRepo(db).get_one(email=settings.TEST_ADMIN_EMAIL)
    assert user_out and user_out == admin_user


def test_get_my_account(client: TestClient, auth_headers_test_user, db: Session):
    r = client.get(f"{_users_api_path}/my/account", headers=auth_headers_test_user)
    assert r.status_code == 200
    user_out = User(**r.json())
    test_user = UserRepo(db).get_one(email=settings.TEST_USER_EMAIL)
    assert user_out
    assert user_out and user_out == test_user


def test_update_my_account(client: TestClient, auth_headers_test_user, db: Session):

    full_name: str = "Тестовый пользователь"
    new_password: str = "p1"

    r = client.put(
        f"{_users_api_path}/my/account",
        headers=auth_headers_test_user,
        json={"full_name": full_name, "password": new_password},
    )
    assert r.status_code == 200
    user_out = User(**r.json())

    test_user = UserRepo(db).get_one(email=settings.TEST_USER_EMAIL)

    assert SecurityRepo.verify_password(new_password, test_user.password)
    assert SecurityRepo.verify_password(new_password, user_out.password)

    assert user_out and test_user and user_out == test_user
    assert test_user.full_name == full_name


def test_create_user(client: TestClient, auth_headers_test_admin, db: Session):
    email = random_email()
    r = client.post(
        f"{_users_api_path}/",
        headers=auth_headers_test_admin,
        json={"email": email, "password": "password"},
    )
    assert r.status_code == 201
    user_out = User(**r.json())
    user_out2 = UserRepo(db).get_one(email=email)
    assert user_out and user_out2 and user_out == user_out2
    UserRepo(db).delete(user_out)


# def test_get_user_by_id(
#     client: TestClient, token_headers_admin, db: Session
# ) -> None:
#     username = random_email()
#     password = random_lower_string()
#     user_in = User(email=username, password=password)
#     user = user.create(db, obj_in=user_in)
#     user_id = user.id
#     r = client.get(f"{settings.API_V_STR}/users/{user_id}", headers=token_headers_admin)
#     assert r.status_code == 200
#     api_user = r.json()
#     existing_user = user.get_one(email=username)
#     assert existing_user
#     assert existing_user.email == api_user["email"]


def test_create_user_existing_email(client: TestClient, auth_headers_test_admin, db: Session):

    password = "password"
    with tmp_user(db, password=password) as user_out:

        data = {"email": user_out.email, "password": password}
        r = client.post(
            f"{_users_api_path}/",
            headers=auth_headers_test_admin,
            json=data,
        )
        user_out = r.json()
        assert r.status_code == 400
        assert "email" not in user_out
