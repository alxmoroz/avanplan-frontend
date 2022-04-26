#  Copyright (c) 2022. Alexandr Moroz

import pytest
from fastapi.encoders import jsonable_encoder
from pydantic import EmailStr
from sqlalchemy.orm import Session

from lib.L2_data.models import WSRole
from lib.L2_data.models.auth import User, Workspace
from lib.L2_data.repositories.db import UserRepo, WSRoleRepo
from lib.L2_data.repositories.db.auth.workspace_repo import WorkspaceRepo
from lib.L2_data.repositories.security_repo import SecurityRepo
from lib.L2_data.schema import UserSchemaUpsert, WorkspaceSchemaUpsert, WSRoleSchemaUpsert
from lib.L2_data.settings import settings
from tests.utils import random_email

TEST_USER_EMAIL = "test@test.com"
TEST_USER_PASSWORD = "test"


def auth_headers_for_user(user_repo: UserRepo, email: str, is_superuser: bool = False):

    user = user_repo.get_one(email=email)
    if not user:
        s = UserSchemaUpsert(
            email=EmailStr(email),
            password=SecurityRepo.secure_password(settings.DEFAULT_ADMIN_PASSWORD if is_superuser else TEST_USER_PASSWORD),
        )
        user_repo.upsert(jsonable_encoder(s))

    token = SecurityRepo.create_token(email).access_token
    return {"Authorization": f"Bearer {token}"}


@pytest.fixture(scope="session")
def auth_headers_test_admin(user_repo: UserRepo) -> dict[str, str]:
    return auth_headers_for_user(user_repo, settings.DEFAULT_ADMIN_EMAIL)


@pytest.fixture(scope="session")
def auth_headers_test_user(user_repo: UserRepo) -> dict[str, str]:
    return auth_headers_for_user(user_repo, TEST_USER_EMAIL)


@pytest.fixture(scope="session")
def user_repo(db: Session) -> UserRepo:
    yield UserRepo(db)


@pytest.fixture(scope="session")
def tmp_user(user_repo: UserRepo) -> User:
    s = UserSchemaUpsert(
        email=EmailStr(random_email()),
        password=SecurityRepo.secure_password("password"),
    )

    user = user_repo.upsert(jsonable_encoder(s))
    yield user
    user_repo.delete(user.id)


@pytest.fixture(scope="session")
def ws_repo(db) -> WorkspaceRepo:
    yield WorkspaceRepo(db)


@pytest.fixture(scope="session")
def tmp_ws(ws_repo) -> Workspace:
    s = WorkspaceSchemaUpsert(title="tmp_ws")
    ws = ws_repo.upsert(jsonable_encoder(s))
    yield ws
    ws_repo.delete(ws.id)


@pytest.fixture(scope="session")
def ws_role_repo(db) -> WSRoleRepo:
    yield WSRoleRepo(db)


@pytest.fixture(scope="session")
def tmp_ws_role(ws_role_repo) -> WSRole:
    s = WSRoleSchemaUpsert(title="tmp_ws_role")
    ws_role = ws_role_repo.upsert(jsonable_encoder(s))
    yield ws_role
    ws_role_repo.delete(ws_role.id)
