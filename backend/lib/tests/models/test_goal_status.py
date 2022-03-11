#  Copyright (c) 2022. Alexandr Moroz

import pytest
from sqlalchemy import column

from lib.L1_domain.entities import GoalStatus
from lib.L2_data.repositories.db import GoalStatusRepo
from lib.L2_data.schema import GoalStatusSchema


def test_get_one(goal_status_repo: GoalStatusRepo, tmp_goal_status):
    obj_out = goal_status_repo.get_one(id=tmp_goal_status.id)
    assert tmp_goal_status == obj_out


def test_get_create(goal_status_repo: GoalStatusRepo, tmp_goal_status):

    obj2: GoalStatus = goal_status_repo.create(GoalStatusSchema(title="test_get"))
    objects = goal_status_repo.get(
        limit=2,
        where=column("id").in_([tmp_goal_status.id, obj2.id]),
    )
    assert tmp_goal_status in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert goal_status_repo.delete(obj2.id) == 1


def test_update(goal_status_repo: GoalStatusRepo, tmp_goal_status):

    s = GoalStatusSchema(
        id=tmp_goal_status.id,
        title="title",
        closed=True,
    )

    obj_out = goal_status_repo.update(s)
    test_obj_out = goal_status_repo.get_one(id=tmp_goal_status.id)

    assert obj_out == test_obj_out
    assert obj_out.title == s.title
    assert obj_out.closed == s.closed


def test_upsert_delete(goal_status_repo: GoalStatusRepo):
    # upsert
    goal_status = GoalStatus(title="test_upsert_delete")
    obj_out = goal_status_repo.update(GoalStatusSchema(title=goal_status.title))
    test_obj_out = goal_status_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert goal_status.title == obj_out.title

    # delete
    assert goal_status_repo.delete(obj_out.id) == 1


@pytest.fixture(scope="module")
def goal_status_repo(db) -> GoalStatusRepo:
    yield GoalStatusRepo(db)


@pytest.fixture(scope="module")
def tmp_goal_status(goal_status_repo: GoalStatusRepo) -> GoalStatus:
    goal_status = goal_status_repo.update(GoalStatusSchema(title="tmp_goal_status"))
    yield goal_status
    goal_status_repo.delete(goal_status.id)
