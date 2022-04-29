#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from sqlalchemy import column

from lib.L2_data.repositories.db import WSUserRoleRepo
from lib.L2_data.schema import WSUserRoleSchemaUpsert


def test_get_one(ws_user_role_repo: WSUserRoleRepo, tmp_ws_user_role):
    obj_out = ws_user_role_repo.get_one(id=tmp_ws_user_role.id)
    assert tmp_ws_user_role == obj_out


def test_get_create(ws_user_role_repo: WSUserRoleRepo, tmp_ws_user_role, tmp_user, tmp_ws, tmp_ws_role):
    data = dict(workspace_id=tmp_ws.id, user_id=tmp_user.id, ws_role_id=tmp_ws_role.id)
    s = WSUserRoleSchemaUpsert(**data)
    obj2 = ws_user_role_repo.upsert(jsonable_encoder(s))
    assert obj2

    objects = ws_user_role_repo.get(where=column("id").in_([tmp_ws_user_role.id, obj2.id]))
    assert tmp_ws_user_role in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert ws_user_role_repo.delete(obj2.id) == 1


def test_update_upsert(ws_user_role_repo: WSUserRoleRepo, tmp_user, tmp_ws, tmp_ws_role):
    # upsert
    data = dict(workspace_id=tmp_ws.id, user_id=tmp_user.id, ws_role_id=tmp_ws_role.id)
    s = WSUserRoleSchemaUpsert(**data)
    obj_out = ws_user_role_repo.upsert(jsonable_encoder(s))
    test_obj_out = ws_user_role_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert obj_out.workspace_id == s.workspace_id
