#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from sqlalchemy import column

from lib.L2_data.repositories.db import WorkspaceRepo
from lib.L2_data.schema import WorkspaceSchemaUpsert


def test_get_one(ws_repo: WorkspaceRepo, tmp_ws):
    obj_out = ws_repo.get_one(id=tmp_ws.id)
    assert tmp_ws == obj_out


def test_get_create(ws_repo: WorkspaceRepo, tmp_ws):
    s = WorkspaceSchemaUpsert(title="test_get_create")
    obj2 = ws_repo.upsert(jsonable_encoder(s))
    assert obj2

    objects = ws_repo.get(
        where=column("id").in_([tmp_ws.id, obj2.id]),
    )
    assert tmp_ws in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert ws_repo.delete(obj2.id) == 1


def test_update(ws_repo: WorkspaceRepo, tmp_ws):

    s = WorkspaceSchemaUpsert(id=tmp_ws.id, title="test_update")

    obj_out = ws_repo.upsert(jsonable_encoder(s))
    test_obj_out = ws_repo.get_one(id=tmp_ws.id)

    assert obj_out == test_obj_out
    assert obj_out.title == s.title


def test_upsert_delete(ws_repo: WorkspaceRepo):
    # upsert
    s = WorkspaceSchemaUpsert(title="test_upsert_delete")
    obj_out = ws_repo.upsert(jsonable_encoder(s))
    test_obj_out = ws_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert s.title == obj_out.title

    # delete
    assert ws_repo.delete(obj_out.id) == 1
