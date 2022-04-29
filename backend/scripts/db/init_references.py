#  Copyright (c) 2022. Alexandr Moroz

import os

from fastapi.encoders import jsonable_encoder

from lib.L2_data.db import session_maker_for_db
from lib.L2_data.schema import WSRoleSchemaUpsert, RemoteTrackerTypeSchemaUpsert
from lib.L2_data.repositories.db import RemoteTrackerTypeRepo, WSRoleRepo


# WS Roles
def _init_ws_roles(db):
    ws_role_repo = WSRoleRepo(db)
    for code in ["admin", "member", "guest"]:
        role_in_db = ws_role_repo.get_one(title=code)
        if not role_in_db:
            s = WSRoleSchemaUpsert(title=code)
            ws_role = ws_role_repo.upsert(jsonable_encoder(s))
            if ws_role:
                print(f"WS Role {ws_role.title} created")


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

        _init_ws_roles(db)
        _init_tracker_types(db)

    finally:
        db.close()


init_data()
