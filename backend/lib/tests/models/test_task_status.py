#  Copyright (c) 2022. Alexandr Moroz

from contextlib import contextmanager
from typing import Generator

import pytest
from sqlalchemy import column

from lib.L1_domain.entities.tracker import TaskStatus
from lib.L2_data.repositories import TaskStatusRepo
from lib.tests.utils import random_lower_string


def test_get_obj(task_status_repo):
    with tmp_object(task_status_repo) as obj:
        obj_out = task_status_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_get_objects(task_status_repo):
    with tmp_object(task_status_repo) as o1, tmp_object(task_status_repo) as o2:
        objects = task_status_repo.get(
            limit=2,
            where=column("id").in_([o1.id, o2.id]),
        )
        assert o1 in objects
        assert o2 in objects
        assert len(objects) == 2


def test_create_object(task_status_repo):
    with tmp_object(task_status_repo) as obj:
        obj_out = task_status_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_update_object(task_status_repo):
    with tmp_object(task_status_repo) as obj_in:
        title = obj_in.title = "title"
        description = obj_in.description = "description"
        closed = obj_in.closed = True
        assert task_status_repo.update(obj_in) == 1

        obj_out = task_status_repo.get_one(id=obj_in.id)
        assert obj_in == obj_out
        assert obj_out.title == title
        assert obj_out.description == description
        assert obj_out.closed == closed


def test_delete_object(task_status_repo):
    with tmp_object(task_status_repo) as obj:
        assert task_status_repo.delete(obj) == 1


@pytest.fixture(scope="module")
def task_status_repo(db) -> TaskStatusRepo:
    yield TaskStatusRepo(db)


@contextmanager
def tmp_object(task_status_repo) -> Generator:
    task_status: TaskStatus | None = None
    try:
        ts = TaskStatus(title=random_lower_string())
        task_status = task_status_repo.create(ts)
        yield task_status
    finally:
        task_status_repo.delete(task_status)
