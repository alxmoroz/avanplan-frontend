#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from sqlalchemy import column

from lib.L1_domain.entities import Goal
from lib.L2_data.repositories.db import GoalRepo
from lib.L2_data.schema import GoalSchemaCreate


def test_get_one(goal_repo: GoalRepo, tmp_goal):
    obj_out = goal_repo.get_one(id=tmp_goal.id)
    assert tmp_goal == obj_out


def test_get_create(goal_repo: GoalRepo, tmp_goal):

    obj2 = goal_repo.create(GoalSchemaCreate(title="test_get"))

    objects = goal_repo.get(
        limit=2,
        where=column("id").in_([tmp_goal.id, obj2.id]),
    )
    assert tmp_goal in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert goal_repo.delete(obj2.id) == 1


def test_update(goal_repo: GoalRepo, tmp_goal):

    s = GoalSchemaCreate(
        id=tmp_goal.id,
        title="title",
        description="description",
        remote_code="remote_code",
        updated_on=datetime.now(),
    )

    obj_out = goal_repo.update(s)
    test_obj_out = goal_repo.get_one(id=tmp_goal.id)

    assert obj_out == test_obj_out
    assert obj_out.title == s.title
    assert obj_out.description == s.description
    assert obj_out.remote_code == s.remote_code
    assert obj_out.updated_on == s.updated_on


def test_upsert_delete(goal_repo: GoalRepo):
    # upsert
    goal = Goal(title="test_upsert_delete")
    obj_out = goal_repo.update(GoalSchemaCreate(title=goal.title))
    test_obj_out = goal_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert goal.title == obj_out.title

    # delete
    assert goal_repo.delete(obj_out.id) == 1
