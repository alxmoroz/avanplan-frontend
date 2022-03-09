#  Copyright (c) 2022. Alexandr Moroz

import pytest
from sqlalchemy import column

from lib.L1_domain.entities import TaskStatus
from lib.L2_data.repositories import TaskStatusRepo
from lib.L2_data.schema import TaskStatusSchema


def test_get_one(task_status_repo: TaskStatusRepo, tmp_task_status):
    obj_out = task_status_repo.get_one(id=tmp_task_status.id)
    assert tmp_task_status == obj_out


def test_get_create(task_status_repo: TaskStatusRepo, tmp_task_status):

    t2 = task_status_repo.create(TaskStatusSchema(title="test_get"))

    objects = task_status_repo.get(
        limit=2,
        where=column("id").in_([tmp_task_status.id, t2.id]),
    )
    assert tmp_task_status in objects
    assert t2 in objects
    assert len(objects) == 2

    assert task_status_repo.delete(t2.id) == 1


def test_update(task_status_repo: TaskStatusRepo, tmp_task_status):

    s = TaskStatusSchema(
        id=tmp_task_status.id,
        title="title",
        closed=True,
    )

    obj_out = task_status_repo.update(s)
    test_obj_out = task_status_repo.get_one(id=tmp_task_status.id)

    assert obj_out == test_obj_out
    assert obj_out.title == s.title
    assert obj_out.closed == s.closed


def test_upsert_delete(task_status_repo: TaskStatusRepo):
    # upsert
    status = TaskStatus(title="test_upsert_delete")
    obj_out = task_status_repo.update(TaskStatusSchema(title=status.title))
    test_obj_out = task_status_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert status.title == obj_out.title

    # delete
    assert task_status_repo.delete(obj_out.id) == 1


@pytest.fixture(scope="module")
def task_status_repo(db) -> TaskStatusRepo:
    yield TaskStatusRepo(db)


@pytest.fixture(scope="module")
def tmp_task_status(task_status_repo: TaskStatusRepo) -> TaskStatus:
    ts = task_status_repo.update(TaskStatusSchema(title="tmp_task_status"))
    yield ts
    task_status_repo.delete(ts.id)
