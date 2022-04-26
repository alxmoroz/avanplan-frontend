#  Copyright (c) 2022. Alexandr Moroz
import os

from fastapi.encoders import jsonable_encoder

from lib.L2_data.models.auth import User, WSUserRole, WSRole, Workspace
from lib.L2_data.repositories.security_repo import SecurityRepo
from lib.L2_data.db import session_maker_for_db
from lib.L2_data.schema import WorkspaceSchemaUpsert, WSRoleSchemaUpsert, WSUserRoleSchemaUpsert, RemoteTrackerTypeSchemaUpsert, UserSchemaUpsert
from lib.L2_data.repositories.db import UserRepo, RemoteTrackerTypeRepo, WorkspaceRepo, WSRoleRepo, WSUserRoleRepo
from lib.L2_data.settings import settings


# Default Admin
def _init_admin(db) -> User:
    user_repo = UserRepo(db)
    admin_user: User = user_repo.get_one(email=settings.DEFAULT_ADMIN_EMAIL)
    if not admin_user:
        s = UserSchemaUpsert(
            email=settings.DEFAULT_ADMIN_EMAIL,
            password=SecurityRepo.secure_password(settings.DEFAULT_ADMIN_PASSWORD),
        )
        admin_user = user_repo.upsert(jsonable_encoder(s))
        if admin_user:
            print(f"Admin created: {admin_user.email}")

    return admin_user


# Work Space
def _init_ws(db, title) -> Workspace:
    ws_repo = WorkspaceRepo(db)
    ws = ws_repo.get_one(title=title)
    if not ws:
        s = WorkspaceSchemaUpsert(title=title)
        ws = ws_repo.upsert(jsonable_encoder(s))
        if ws:
            print(f"Workspace {ws.title} created")

    return ws


# WS Role
def _init_admin_role(db) -> WSRole:
    ws_role_repo = WSRoleRepo(db)
    ws_role = ws_role_repo.get_one(title="admin")
    if not ws_role:
        s = WSRoleSchemaUpsert(title="admin")
        ws_role = ws_role_repo.upsert(jsonable_encoder(s))
        if ws_role:
            print(f"WS Role {ws_role.title} created")
    return ws_role


def _init_ws_user_role(db, ws: Workspace, user: User, role: WSRole) -> WSUserRole:
    repo = WSUserRoleRepo(db)
    data = dict(workspace_id=ws.id, user_id=user.id, ws_role_id=role.id)
    ws_user_role = repo.get_one(**data)
    if not ws_user_role:
        s = WSUserRoleSchemaUpsert(**data)
        ws_user_role = repo.upsert(jsonable_encoder(s))
        if ws_user_role:
            print(f"WS Role {ws_user_role.id} created")
    return ws_user_role


# Remote Tracker types
def _init_tracker_types(db):
    repo = RemoteTrackerTypeRepo(db)
    for code in ["Redmine", "Jira", "Trello"]:
        type_in_db = repo.get_one(title=code)
        if not type_in_db:
            repo.upsert(jsonable_encoder(RemoteTrackerTypeSchemaUpsert(title=code)))
            print(f"Remote Tracker type {code} created")


def init_data():
    db = None
    try:
        db = session_maker_for_db(os.getenv("DB_NAME"))()

        admin = _init_admin(db)
        ws = _init_ws(db, admin.email)
        role = _init_admin_role(db)
        _init_ws_user_role(db, ws, admin, role)
        _init_tracker_types(db)

    finally:
        db.close()


init_data()
