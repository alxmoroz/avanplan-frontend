#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from sqlalchemy import column

from lib.L2_data.repositories.db import RemoteTrackerTypeRepo
from lib.L2_data.schema import RemoteTrackerTypeSchemaUpsert


def test_get_one(remote_tracker_type_repo: RemoteTrackerTypeRepo, tmp_remote_tracker_type):
    obj_out = remote_tracker_type_repo.get_one(id=tmp_remote_tracker_type.id)
    assert tmp_remote_tracker_type == obj_out


def test_get_create(remote_tracker_type_repo: RemoteTrackerTypeRepo, tmp_remote_tracker_type):
    s = RemoteTrackerTypeSchemaUpsert(title="test_get_create")
    t2 = remote_tracker_type_repo.upsert(jsonable_encoder(s))

    objects = remote_tracker_type_repo.get(
        where=column("id").in_([tmp_remote_tracker_type.id, t2.id]),
    )
    assert tmp_remote_tracker_type in objects
    assert t2 in objects
    assert len(objects) == 2

    assert remote_tracker_type_repo.delete(t2.id) == 1


def test_update(remote_tracker_type_repo: RemoteTrackerTypeRepo, tmp_remote_tracker_type):

    s = RemoteTrackerTypeSchemaUpsert(id=tmp_remote_tracker_type.id, title="test_update")

    obj_out = remote_tracker_type_repo.upsert(jsonable_encoder(s))
    test_obj_out = remote_tracker_type_repo.get_one(id=tmp_remote_tracker_type.id)

    assert obj_out == test_obj_out
    assert obj_out.title == s.title


def test_upsert_delete(remote_tracker_type_repo: RemoteTrackerTypeRepo):
    # upsert
    s = RemoteTrackerTypeSchemaUpsert(title="test_upsert_delete")
    obj_out = remote_tracker_type_repo.upsert(jsonable_encoder(s))
    test_obj_out = remote_tracker_type_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert s.title == obj_out.title

    # delete
    assert remote_tracker_type_repo.delete(obj_out.id) == 1
