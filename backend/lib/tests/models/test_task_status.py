#  Copyright (c) 2022. Alexandr Moroz


import pytest
from sqlalchemy import column

from lib.L1_domain.entities.goals import TaskStatus
from lib.L2_data.repositories import TaskStatusRepo


def test_get_one(task_status_repo, tmp_task_status):
    obj_out = task_status_repo.get_one(id=tmp_task_status.id)
    assert tmp_task_status == obj_out


def test_get_create(task_status_repo, tmp_task_status):

    t2 = task_status_repo.create(TaskStatus(title="test_get"))

    objects = task_status_repo.get(
        limit=2,
        where=column("id").in_([tmp_task_status.id, t2.id]),
    )
    assert tmp_task_status in objects
    assert t2 in objects
    assert len(objects) == 2

    assert task_status_repo.delete(t2) == 1


def test_update(task_status_repo, tmp_task_status):
    title = tmp_task_status.title = "title"
    closed = tmp_task_status.closed = True
    assert task_status_repo.update(tmp_task_status) == 1

    obj_out = task_status_repo.get_one(id=tmp_task_status.id)
    assert tmp_task_status == obj_out
    assert obj_out.title == title
    assert obj_out.closed == closed


def test_upsert_delete(task_status_repo):
    # create
    task_status = TaskStatus(title="test_upsert_delete")
    obj_out = task_status_repo.upsert(task_status)
    # TODO: Если убрать айдишники под капот (в Л2, в схемы в репах), то тут их не будет
    task_status.id = obj_out.id
    assert task_status_repo.upsert(task_status) == task_status

    # update
    task_status.title = "test_upsert_delete_edit"
    assert task_status_repo.upsert(task_status) == task_status

    # delete
    assert task_status_repo.delete(task_status) == 1


@pytest.fixture(scope="module")
def task_status_repo(db) -> TaskStatusRepo:
    yield TaskStatusRepo(db)


@pytest.fixture(scope="module")
def tmp_task_status(task_status_repo) -> TaskStatus:
    ts = task_status_repo.upsert(TaskStatus(title="tmp_task_status"))
    yield ts
    task_status_repo.delete(ts)
