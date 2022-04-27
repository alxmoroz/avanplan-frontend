#  Copyright (c) 2022. Alexandr Moroz

import pytest
from fastapi.encoders import jsonable_encoder
from sqlalchemy import column

from lib.L2_data.models import TaskPriority
from lib.L2_data.repositories.db import TaskPriorityRepo
from lib.L2_data.schema import TaskPrioritySchemaUpsert


def test_get_one(task_priority_repo: TaskPriorityRepo, tmp_task_priority):
    obj_out = task_priority_repo.get_one(id=tmp_task_priority.id)
    assert tmp_task_priority == obj_out


def test_get_create(task_priority_repo: TaskPriorityRepo, tmp_task_priority, tmp_ws):
    s = TaskPrioritySchemaUpsert(
        title="test_get_create",
        order=2,
        workspace_id=tmp_ws.id,
    )
    obj2 = task_priority_repo.upsert(jsonable_encoder(s))
    assert obj2

    objects = task_priority_repo.get(
        where=column("id").in_([tmp_task_priority.id, obj2.id]),
    )
    assert tmp_task_priority in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert task_priority_repo.delete(obj2.id) == 1


def test_update(task_priority_repo: TaskPriorityRepo, tmp_task_priority, tmp_ws):

    s = TaskPrioritySchemaUpsert(
        id=tmp_task_priority.id,
        title="test_update",
        order=2,
        workspace_id=tmp_ws.id,
    )

    obj_out = task_priority_repo.upsert(jsonable_encoder(s))
    test_obj_out = task_priority_repo.get_one(id=tmp_task_priority.id)

    assert obj_out == test_obj_out
    assert obj_out.title == s.title
    assert obj_out.order == s.order


def test_upsert_delete(task_priority_repo: TaskPriorityRepo, tmp_ws):
    # upsert
    s = TaskPrioritySchemaUpsert(
        title="test_upsert_delete",
        order=1,
        workspace_id=tmp_ws.id,
    )
    obj_out = task_priority_repo.upsert(jsonable_encoder(s))
    test_obj_out = task_priority_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert s.title == obj_out.title

    # delete
    assert task_priority_repo.delete(obj_out.id) == 1


@pytest.fixture(scope="module")
def task_priority_repo(db) -> TaskPriorityRepo:
    yield TaskPriorityRepo(db)


@pytest.fixture(scope="module")
def tmp_task_priority(task_priority_repo, tmp_ws) -> TaskPriority:
    s = TaskPrioritySchemaUpsert(
        title="tmp_task_priority",
        order=1,
        workspace_id=tmp_ws.id,
    )
    tp = task_priority_repo.upsert(jsonable_encoder(s))
    yield tp
    task_priority_repo.delete(tp.id)
