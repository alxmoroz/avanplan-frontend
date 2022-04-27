#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from sqlalchemy import column

from lib.L2_data.repositories.db import WSRoleRepo
from lib.L2_data.schema import WSRoleSchemaUpsert


def test_get_one(ws_role_repo: WSRoleRepo, tmp_ws_role):
    obj_out = ws_role_repo.get_one(id=tmp_ws_role.id)
    assert tmp_ws_role == obj_out


def test_get_create(ws_role_repo: WSRoleRepo, tmp_ws_role):
    s = WSRoleSchemaUpsert(title="test_get_create")
    obj2 = ws_role_repo.upsert(jsonable_encoder(s))
    assert obj2

    objects = ws_role_repo.get(
        where=column("id").in_([tmp_ws_role.id, obj2.id]),
    )
    assert tmp_ws_role in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert ws_role_repo.delete(obj2.id) == 1


def test_update(ws_role_repo: WSRoleRepo, tmp_ws_role):

    s = WSRoleSchemaUpsert(id=tmp_ws_role.id, title="test_update")

    obj_out = ws_role_repo.upsert(jsonable_encoder(s))
    test_obj_out = ws_role_repo.get_one(id=tmp_ws_role.id)

    assert obj_out == test_obj_out
    assert obj_out.title == s.title


def test_upsert_delete(ws_role_repo: WSRoleRepo):
    # upsert
    s = WSRoleSchemaUpsert(title="test_upsert_delete")
    obj_out = ws_role_repo.upsert(jsonable_encoder(s))
    test_obj_out = ws_role_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert s.title == obj_out.title

    # delete
    assert ws_role_repo.delete(obj_out.id) == 1
