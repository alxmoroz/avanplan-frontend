#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from sqlalchemy import column

from lib.L2_data.repositories.db import GoalRepo
from lib.L2_data.schema import GoalSchemaUpsert


def test_get_one(goal_repo: GoalRepo, tmp_goal):
    obj_out = goal_repo.get_one(id=tmp_goal.id)
    assert tmp_goal == obj_out


def test_get_create(goal_repo: GoalRepo, tmp_goal):
    s = GoalSchemaUpsert(title="test_get_create")
    obj2 = goal_repo.upsert(jsonable_encoder(s))

    objects = goal_repo.get(
        limit=2,
        where=column("id").in_([tmp_goal.id, obj2.id]),
    )
    assert tmp_goal in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert goal_repo.delete(obj2.id) == 1


def test_update(goal_repo: GoalRepo, tmp_goal):

    s = GoalSchemaUpsert(
        id=tmp_goal.id,
        title="test_update",
        description="description",
    )

    obj_out = goal_repo.upsert(jsonable_encoder(s))
    test_obj_out = goal_repo.get_one(id=tmp_goal.id)

    assert obj_out == test_obj_out
    assert obj_out.title == s.title
    assert obj_out.description == s.description


def test_upsert_delete(goal_repo: GoalRepo):
    # upsert
    s = GoalSchemaUpsert(title="test_upsert_delete")
    obj_out = goal_repo.upsert(jsonable_encoder(s))
    test_obj_out = goal_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert s.title == obj_out.title

    # delete
    assert goal_repo.delete(obj_out.id) == 1
