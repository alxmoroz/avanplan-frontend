#  Copyright (c) 2022. Alexandr Moroz

from contextlib import contextmanager
from typing import Generator

import pytest
from sqlalchemy import column

from lib.L1_domain.entities.tracker import TaskPriority
from lib.L2_data.repositories import TaskPriorityRepo
from lib.tests.utils import random_lower_string


def test_get_obj(task_priority_repo):
    with tmp_object(task_priority_repo) as obj:
        obj_out = task_priority_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_get_objects(task_priority_repo):
    with tmp_object(task_priority_repo) as o1, tmp_object(task_priority_repo) as o2:
        objects = task_priority_repo.get(
            limit=2,
            where=column("id").in_([o1.id, o2.id]),
        )
        assert o1 in objects
        assert o2 in objects
        assert len(objects) == 2


def test_create_object(task_priority_repo):
    with tmp_object(task_priority_repo) as obj:
        obj_out = task_priority_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_update_object(task_priority_repo):
    with tmp_object(task_priority_repo) as obj_in:
        title = obj_in.title = "title"
        description = obj_in.description = "description"
        order = obj_in.order = 2
        assert task_priority_repo.update(obj_in) == 1

        obj_out = task_priority_repo.get_one(id=obj_in.id)
        assert obj_in == obj_out
        assert obj_out.title == title
        assert obj_out.description == description
        assert obj_out.order == order


def test_delete_object(task_priority_repo):
    with tmp_object(task_priority_repo) as obj:
        assert task_priority_repo.delete(obj) == 1


@pytest.fixture(scope="module")
def task_priority_repo(db) -> TaskPriorityRepo:
    yield TaskPriorityRepo(db)


@contextmanager
def tmp_object(task_priority_repo) -> Generator:
    task_status: TaskPriority | None = None
    try:
        ts = TaskPriority(title=random_lower_string())
        task_status = task_priority_repo.create(ts)
        yield task_status
    finally:
        task_priority_repo.delete(task_status)
