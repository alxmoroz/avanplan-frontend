#  Copyright (c) 2022. Alexandr Moroz

import pytest
from fastapi.encoders import jsonable_encoder
from pydantic import EmailStr
from sqlalchemy.orm import Session

from lib.L2_data.models.users import User
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.repositories.security_repo import SecurityRepo
from lib.L2_data.schema import UserSchemaUpsert
from lib.L2_data.settings import settings
from lib.tests.utils import random_email


def auth_headers_for_user(user_repo: UserRepo, email: str, is_superuser: bool = False):

    user = user_repo.get_one(email=email)
    if not user:
        s = UserSchemaUpsert(
            email=EmailStr(email),
            password=SecurityRepo.secure_password(settings.TEST_ADMIN_PASSWORD if is_superuser else settings.TEST_USER_PASSWORD),
            is_superuser=is_superuser,
        )
        user_repo.upsert(jsonable_encoder(s))

    token = SecurityRepo.create_token(email).access_token
    return {"Authorization": f"Bearer {token}"}


@pytest.fixture(scope="session")
def auth_headers_test_admin(user_repo: UserRepo) -> dict[str, str]:
    return auth_headers_for_user(user_repo, settings.TEST_ADMIN_EMAIL, is_superuser=True)


@pytest.fixture(scope="session")
def auth_headers_test_user(user_repo: UserRepo) -> dict[str, str]:
    return auth_headers_for_user(user_repo, settings.TEST_USER_EMAIL)


@pytest.fixture(scope="session")
def user_repo(db: Session) -> UserRepo:
    yield UserRepo(db)


@pytest.fixture(scope="module")
def tmp_user(user_repo: UserRepo) -> User:
    s = UserSchemaUpsert(
        email=EmailStr(random_email()),
        password=SecurityRepo.secure_password("password"),
    )

    user = user_repo.upsert(jsonable_encoder(s))
    yield user
    user_repo.delete(user.id)
