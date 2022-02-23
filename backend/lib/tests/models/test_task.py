#  Copyright (c) 2022. Alexandr Moroz

from contextlib import contextmanager
from datetime import datetime
from typing import Generator

import pytest
from sqlalchemy import column

from lib.L1_domain.entities.tracker import Task
from lib.L2_data.repositories import TaskRepo
from lib.tests.utils import random_lower_string


def test_get_obj(task_repo):
    with tmp_object(task_repo) as obj:
        obj_out = task_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_get_objects(task_repo):
    with tmp_object(task_repo) as o1, tmp_object(task_repo) as o2:
        objects = task_repo.get(
            limit=2,
            where=column("id").in_([o1.id, o2.id]),
        )
        assert o1 in objects
        assert o2 in objects
        assert len(objects) == 2


def test_create_object(task_repo):
    with tmp_object(task_repo) as obj:
        obj_out = task_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_update_object(task_repo):
    with tmp_object(task_repo) as obj_in:
        title = obj_in.title = "title"
        description = obj_in.description = "description"
        remote_code = obj_in.remote_code = "remote_code"
        imported_on = obj_in.imported_on = datetime.now()
        start_date = obj_in.start_date = datetime.now()
        due_date = obj_in.due_date = datetime.now()
        assert task_repo.update(obj_in) == 1

        obj_out = task_repo.get_one(id=obj_in.id)
        assert obj_in == obj_out
        assert obj_out.title == title
        assert obj_out.description == description
        assert obj_out.remote_code == remote_code
        assert obj_out.imported_on == imported_on
        assert obj_out.start_date == start_date
        assert obj_out.due_date == due_date


def test_delete_object(task_repo):
    with tmp_object(task_repo) as obj:
        assert task_repo.delete(obj) == 1


@pytest.fixture(scope="module")
def task_repo(db) -> TaskRepo:
    yield TaskRepo(db)


@contextmanager
def tmp_object(task_repo) -> Generator:
    task: Task | None = None
    try:
        task = task_repo.create(Task(title=random_lower_string()))
        yield task
    finally:
        task_repo.delete(task)
