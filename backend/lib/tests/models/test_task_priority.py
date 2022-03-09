#  Copyright (c) 2022. Alexandr Moroz

import pytest
from sqlalchemy import column

from lib.L1_domain.entities.goals import TaskPriority
from lib.L2_data.repositories import TaskPriorityRepo
from lib.L2_data.schema import TaskPrioritySchema


def test_get_one(task_priority_repo: TaskPriorityRepo, tmp_task_priority):
    obj_out = task_priority_repo.get_one(id=tmp_task_priority.id)
    assert tmp_task_priority == obj_out


def test_get_create(task_priority_repo: TaskPriorityRepo, tmp_task_priority):

    obj2 = task_priority_repo.create(TaskPrioritySchema(title="test_get", order=2))
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

    obj_out = task_priority_repo.update(s)
    test_obj_out = task_priority_repo.get_one(id=tmp_task_priority.id)

    assert obj_out == test_obj_out
    assert obj_out.title == s.title
    assert obj_out.order == s.order


def test_upsert_delete(task_priority_repo: TaskPriorityRepo):
    # upsert
    tp = TaskPriority(title="test_upsert_delete")
    obj_out = task_priority_repo.update(TaskPrioritySchema(title=tp.title, order=1))
    test_obj_out = task_priority_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert tp.title == obj_out.title

    # delete
    assert task_priority_repo.delete(obj_out.id) == 1


@pytest.fixture(scope="module")
def task_priority_repo(db) -> TaskPriorityRepo:
    yield TaskPriorityRepo(db)


@pytest.fixture(scope="module")
def tmp_task_priority(task_priority_repo) -> TaskPriority:
    tp = task_priority_repo.update(TaskPrioritySchema(title="tmp_task_priority", order=1))
    yield tp
    task_priority_repo.delete(tp.id)
