#  Copyright (c) 2022. Alexandr Moroz


import pytest
from sqlalchemy import column

from lib.L1_domain.entities.goals import TaskPriority
from lib.L2_data.repositories import TaskPriorityRepo


def test_get_one(task_priority_repo, tmp_task_priority):
    obj_out = task_priority_repo.get_one(id=tmp_task_priority.id)
    assert tmp_task_priority == obj_out


def test_get_create(task_priority_repo, tmp_task_priority):

    obj2 = task_priority_repo.create(TaskPriority(title="test_get"))
    assert obj2

    objects = task_priority_repo.get(
        limit=2,
        where=column("id").in_([tmp_task_priority.id, obj2.id]),
    )
    assert tmp_task_priority in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert task_priority_repo.delete(obj2.id) == 1


def test_update(task_priority_repo, tmp_task_priority):

    title = tmp_task_priority.title = "title"
    order = tmp_task_priority.order = 2
    assert task_priority_repo.update(tmp_task_priority) == 1

    obj_out = task_priority_repo.get_one(id=tmp_task_priority.id)
    assert tmp_task_priority == obj_out
    assert obj_out.title == title
    assert obj_out.order == order


def test_upsert_delete(task_priority_repo):
    # create
    tp = TaskPriority(title="test_upsert_delete")
    obj_out = task_priority_repo.upsert(tp)
    # TODO: Если убрать айдишники под капот (в Л2, в схемы в репах), то тут их не будет
    tp.id = obj_out.id
    assert task_priority_repo.upsert(tp) == tp

    # update
    tp.title = "test_upsert_delete_edit"
    assert task_priority_repo.upsert(tp) == tp

    # delete
    assert task_priority_repo.delete(tp.id) == 1


@pytest.fixture(scope="module")
def task_priority_repo(db) -> TaskPriorityRepo:
    yield TaskPriorityRepo(db)


@pytest.fixture(scope="module")
def tmp_task_priority(task_priority_repo) -> TaskPriority:
    tp = task_priority_repo.upsert(TaskPriority(title="tmp_task_priority"))
    yield tp
    task_priority_repo.delete(tp.id)
