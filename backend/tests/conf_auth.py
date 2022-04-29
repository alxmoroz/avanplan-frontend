#  Copyright (c) 2022. Alexandr Moroz

import pytest
from fastapi.encoders import jsonable_encoder
from pydantic import EmailStr
from sqlalchemy.orm import Session

from lib.L2_data.models import WSRole, WSUserRole
from lib.L2_data.models.auth import User, Workspace
from lib.L2_data.repositories.db import UserRepo, WorkspaceRepo, WSRoleRepo, WSUserRoleRepo
from lib.L2_data.repositories.security_repo import SecurityRepo
from lib.L2_data.schema import UserSchemaUpsert, WorkspaceSchemaUpsert, WSRoleSchemaUpsert, WSUserRoleSchemaUpsert
from tests.utils import random_email


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
def auth_headers_tmp_user(tmp_user: User) -> dict[str, str]:
    token = SecurityRepo.create_token(tmp_user.email).access_token
    return {"Authorization": f"Bearer {token}"}


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


@pytest.fixture(scope="session")
def ws_user_role_repo(db) -> WSUserRoleRepo:
    yield WSUserRoleRepo(db)


@pytest.fixture(scope="session")
def tmp_ws_user_role(ws_user_role_repo, tmp_user, tmp_ws, tmp_ws_role) -> WSUserRole:
    data = dict(workspace_id=tmp_ws.id, user_id=tmp_user.id, ws_role_id=tmp_ws_role.id)
    s = WSUserRoleSchemaUpsert(**data)
    ws_user_role = ws_user_role_repo.upsert(jsonable_encoder(s))
    yield ws_user_role
    ws_user_role_repo.delete(ws_user_role.id)
