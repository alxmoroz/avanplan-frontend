#  Copyright (c) 2022. Alexandr Moroz
from contextlib import contextmanager
from typing import Generator

import pytest
from sqlalchemy.orm import Session

from lib.L1_domain.entities.users import User
from lib.L2_data.repositories import SecurityRepo, UserRepo
from lib.L2_data.settings import settings
from lib.tests.utils import random_email, random_lower_string


def auth_headers_for_user(user_repo, email: str, is_superuser: bool = False):

    user = user_repo.get_one(email=email)
    if not user:
        user_repo.create(
            User(
                email=email,
                password=SecurityRepo.secure_password(settings.TEST_ADMIN_PASSWORD if is_superuser else settings.TEST_USER_PASSWORD),
                is_superuser=is_superuser,
            ),
        )

    token = SecurityRepo.create_token(email).access_token
    return {"Authorization": f"Bearer {token}"}


@pytest.fixture(scope="session")
def auth_headers_test_admin(user_repo) -> dict[str, str]:
    return auth_headers_for_user(user_repo, settings.TEST_ADMIN_EMAIL, is_superuser=True)


@pytest.fixture(scope="session")
def auth_headers_test_user(user_repo) -> dict[str, str]:
    return auth_headers_for_user(user_repo, settings.TEST_USER_EMAIL)


@pytest.fixture(scope="session")
def user_repo(db: Session) -> UserRepo:
    yield UserRepo(db)


# TODO: переделать в фикстуру с yield (см. как в задачах и проектах сделано)


@contextmanager
def tmp_object(
    repo,
    password: str | None = None,
    is_active: bool = True,
) -> Generator:
    user: User | None = None
    try:
        user = repo.create(
            User(
                email=random_email(),
                password=SecurityRepo.secure_password(password or random_lower_string()),
                is_active=is_active,
            )
        )
        yield user
    finally:
        repo.delete(user.id)
