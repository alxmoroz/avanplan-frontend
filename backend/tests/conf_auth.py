#  Copyright (c) 2022. Alexandr Moroz

import pytest
from fastapi.encoders import jsonable_encoder
from pydantic import EmailStr
from sqlalchemy.orm import Session

from lib.L2_data.models_auth import Organization, User
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.repositories.db.auth.organization_repo import OrganizationRepo
from lib.L2_data.repositories.security_repo import SecurityRepo
from lib.L2_data.schema import OrganizationSchemaUpsert, UserSchemaUpsert
from lib.L2_data.settings import settings
from tests.utils import random_email

TEST_USER_EMAIL = "test@test.com"
TEST_USER_PASSWORD = "test"


def auth_headers_for_user(user_repo: UserRepo, tmp_org: Organization, email: str, is_superuser: bool = False):

    user = user_repo.get_one(email=email, organization_id=tmp_org.id)
    if not user:
        s = UserSchemaUpsert(
            email=EmailStr(email),
            password=SecurityRepo.secure_password(settings.DEFAULT_ADMIN_PASSWORD if is_superuser else TEST_USER_PASSWORD),
            is_superuser=is_superuser,
            organization_id=tmp_org.id,
        )
        user_repo.upsert(jsonable_encoder(s))

    token = SecurityRepo.create_token(email).access_token
    return {"Authorization": f"Bearer {token}"}


@pytest.fixture(scope="session")
def auth_headers_test_admin(user_repo: UserRepo, tmp_org: Organization) -> dict[str, str]:
    return auth_headers_for_user(user_repo, tmp_org, settings.DEFAULT_ADMIN_EMAIL, is_superuser=True)


@pytest.fixture(scope="session")
def auth_headers_test_user(user_repo: UserRepo, tmp_org: Organization) -> dict[str, str]:
    return auth_headers_for_user(user_repo, tmp_org, TEST_USER_EMAIL)


@pytest.fixture(scope="session")
def user_repo(db_auth: Session) -> UserRepo:
    yield UserRepo(db_auth)


@pytest.fixture(scope="module")
def tmp_user(user_repo: UserRepo, tmp_org: Organization) -> User:
    s = UserSchemaUpsert(
        email=EmailStr(random_email()),
        password=SecurityRepo.secure_password("password"),
        organization_id=tmp_org.id,
    )

    user = user_repo.upsert(jsonable_encoder(s))
    yield user
    user_repo.delete(user.id)


@pytest.fixture(scope="session")
def organization_repo(db_auth: Session) -> OrganizationRepo:
    yield OrganizationRepo(db_auth)


@pytest.fixture(scope="session")
def tmp_org(organization_repo: OrganizationRepo) -> Organization:
    org = organization_repo.get_one(name="test")
    if not org:
        s = OrganizationSchemaUpsert(name="test")
        org = organization_repo.upsert(jsonable_encoder(s))
    yield org
