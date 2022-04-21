#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from pydantic import HttpUrl
from sqlalchemy import column

from lib.L2_data.repositories.db import RemoteTrackerRepo
from lib.L2_data.schema import RemoteTrackerSchemaUpsert


def test_get_one(remote_tracker_repo: RemoteTrackerRepo, tmp_remote_tracker):
    obj_out = remote_tracker_repo.get_one(id=tmp_remote_tracker.id)
    assert tmp_remote_tracker == obj_out


def test_get_create(remote_tracker_repo: RemoteTrackerRepo, tmp_remote_tracker, tmp_remote_tracker_type):
    s = RemoteTrackerSchemaUpsert(
        description="test_get_create",
        remote_tracker_type_id=tmp_remote_tracker_type.id,
        url=HttpUrl("https://test.url", scheme="https"),
        login_key="login",
    )
    t2 = remote_tracker_repo.upsert(jsonable_encoder(s))

    objects = remote_tracker_repo.get(
        limit=2,
        where=column("id").in_([tmp_remote_tracker.id, t2.id]),
    )
    assert tmp_remote_tracker in objects
    assert t2 in objects
    assert len(objects) == 2

    assert remote_tracker_repo.delete(t2.id) == 1


def test_update(remote_tracker_repo: RemoteTrackerRepo, tmp_remote_tracker, tmp_remote_tracker_type):

    s = RemoteTrackerSchemaUpsert(
        id=tmp_remote_tracker.id,
        description="test_update",
        remote_tracker_type_id=tmp_remote_tracker_type.id,
        url=HttpUrl("https://test_update.url", scheme="https"),
        login_key="login2",
    )

    obj_out = remote_tracker_repo.upsert(jsonable_encoder(s))
    test_obj_out = remote_tracker_repo.get_one(id=tmp_remote_tracker.id)

    assert obj_out == test_obj_out
    assert obj_out.description == s.description
    assert obj_out.remote_tracker_type_id == s.remote_tracker_type_id
    assert obj_out.url == s.url
    assert obj_out.login_key == s.login_key


def test_upsert_delete(remote_tracker_repo: RemoteTrackerRepo, tmp_remote_tracker_type):
    # upsert
    s = RemoteTrackerSchemaUpsert(
        description="test_upsert_delete",
        remote_tracker_type_id=tmp_remote_tracker_type.id,
        url=HttpUrl("https://test.url", scheme="https"),
        login_key="login",
    )
    obj_out = remote_tracker_repo.upsert(jsonable_encoder(s))
    test_obj_out = remote_tracker_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert s.description == obj_out.description

    # delete
    assert remote_tracker_repo.delete(obj_out.id) == 1
