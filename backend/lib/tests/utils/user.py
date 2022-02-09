#  Copyright (c) 2022. Alexandr Moroz

import random
import string

from fastapi.testclient import TestClient

from lib.L1_domain.entities.auth import CreateUser, UpdateUser
from lib.L3_data.repositories import user_repo
from lib.L2_app.extra.config import settings
from lib.L3_data.models.auth.user import User
from sqlalchemy.orm import Session


def random_lower_string() -> str:
    return "".join(random.choices(string.ascii_lowercase, k=8))


def random_email() -> str:
    return f"{random_lower_string()}@{random_lower_string()}.com"


def get_superuser_token_headers(client: TestClient) -> dict[str, str]:
    login_data = {
        "username": settings.FIRST_SUPERUSER_EMAIL,
        "password": settings.FIRST_SUPERUSER_PASSWORD,
    }
    r = client.post(f"{settings.API_PATH}/auth/token", data=login_data)
    token = r.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}
    return headers


def user_auth_headers(
        *, client: TestClient, email: str, password: str
) -> dict[str, str]:
    data = {"username": email, "password": password}

    r = client.post(f"{settings.API_PATH}/auth/token", data=data)
    response = r.json()
    token = response["access_token"]
    headers = {"Authorization": f"Bearer {token}"}
    return headers


def create_random_user(db: Session) -> User:
    email = random_email()
    password = random_lower_string()
    user_in = CreateUser(username=email, email=email, password=password)
    user = user_repo.create(db=db, obj_in=user_in)
    return user


def auth_headers_from_email(
        *, client: TestClient, email: str, db: Session
) -> dict[str, str]:
    """
    Return a valid token for the user with given email.

    If the user doesn't exist it is created first.
    """
    password = random_lower_string()
    user = user_repo.get_by_email(db, email=email)
    if not user:
        user_in_create = CreateUser(username=email, email=email, password=password)
        user_repo.create(db, obj_in=user_in_create)
    else:
        user_in_update = UpdateUser(password=password)
        user_repo.update(db, db_obj=user, obj_in=user_in_update)

    return user_auth_headers(client=client, email=email, password=password)
