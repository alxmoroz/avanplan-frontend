#  Copyright (c) 2022. Alexandr Moroz

from contextlib import contextmanager
from datetime import datetime
from typing import Generator

from sqlalchemy import column

from lib.L1_domain.entities.tracker import Goal
from lib.tests.utils import random_lower_string


def test_get_one(goal_repo):
    with tmp_object(goal_repo) as obj:
        obj_out = goal_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_get(goal_repo):
    with tmp_object(goal_repo) as o1, tmp_object(goal_repo) as o2:
        objects = goal_repo.get(
            limit=2,
            where=column("id").in_([o1.id, o2.id]),
        )
        assert o1 in objects
        assert o2 in objects
        assert len(objects) == 2


def test_create(goal_repo):
    with tmp_object(goal_repo) as obj:
        obj_out = goal_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_update(goal_repo):
    with tmp_object(goal_repo) as obj_in:
        title = obj_in.title = "title"
        description = obj_in.description = "description"
        remote_code = obj_in.remote_code = "remote_code"
        imported_on = obj_in.imported_on = datetime.now()

        assert goal_repo.update(obj_in) == 1

        obj_out = goal_repo.get_one(id=obj_in.id)
        assert obj_in == obj_out
        assert obj_out.title == title
        assert obj_out.description == description
        assert obj_out.remote_code == remote_code
        assert obj_out.imported_on == imported_on


def test_delete(goal_repo):
    with tmp_object(goal_repo) as obj:
        assert goal_repo.delete(obj) == 1


@contextmanager
def tmp_object(goal_repo) -> Generator:
    goal: Goal | None = None
    try:
        goal = goal_repo.create(Goal(title=random_lower_string()))
        yield goal
    finally:
        goal_repo.delete(goal)
