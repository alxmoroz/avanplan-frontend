#  Copyright (c) 2022. Alexandr Moroz

import pytest
from fastapi.encoders import jsonable_encoder
from sqlalchemy import column

from lib.L2_data.models import TaskPriority
from lib.L2_data.repositories.db import TaskPriorityRepo
from lib.L2_data.schema import TaskPrioritySchema


def test_get_one(task_priority_repo: TaskPriorityRepo, tmp_task_priority):
    obj_out = task_priority_repo.get_one(id=tmp_task_priority.id)
    assert tmp_task_priority == obj_out


def test_get_create(task_priority_repo: TaskPriorityRepo, tmp_task_priority):
    s = TaskPrioritySchema(title="test_get", order=2)
    obj2 = task_priority_repo.create(jsonable_encoder(s))
    assert obj2

    objects = task_priority_repo.get(
        limit=2,
        where=column("id").in_([tmp_task_priority.id, obj2.id]),
    )
    assert tmp_task_priority in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert task_priority_repo.delete(obj2.id) == 1


def test_update(task_priority_repo: TaskPriorityRepo, tmp_task_priority):

    s = TaskPrioritySchema(
        id=tmp_task_priority.id,
        title="title",
        order=2,
    )

    obj_out = task_priority_repo.update(jsonable_encoder(s))
    test_obj_out = task_priority_repo.get_one(id=tmp_task_priority.id)

    assert obj_out == test_obj_out
    assert obj_out.title == s.title
    assert obj_out.order == s.order


def test_upsert_delete(task_priority_repo: TaskPriorityRepo):
    # upsert
    s = TaskPrioritySchema(title="test_upsert_delete", order=1)
    obj_out = task_priority_repo.update(jsonable_encoder(s))
    test_obj_out = task_priority_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert s.title == obj_out.title

    # delete
    assert task_priority_repo.delete(obj_out.id) == 1


@pytest.fixture(scope="module")
def task_priority_repo(db) -> TaskPriorityRepo:
    yield TaskPriorityRepo(db)


@pytest.fixture(scope="module")
def tmp_task_priority(task_priority_repo) -> TaskPriority:
    s = TaskPrioritySchema(title="tmp_task_priority", order=1)
    tp = task_priority_repo.update(jsonable_encoder(s))
    yield tp
    task_priority_repo.delete(tp.id)
