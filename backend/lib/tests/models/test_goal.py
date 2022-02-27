#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from sqlalchemy import column

from lib.L1_domain.entities.goals import Goal


def test_get_one(goal_repo, tmp_goal):
    obj_out = goal_repo.get_one(id=tmp_goal.id)
    assert tmp_goal == obj_out


def test_get_create(goal_repo, tmp_goal):

    obj2 = goal_repo.create(Goal(title="test_get"))

    objects = goal_repo.get(
        limit=2,
        where=column("id").in_([tmp_goal.id, obj2.id]),
    )
    assert tmp_goal in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert goal_repo.delete(obj2) == 1


def test_update(goal_repo, tmp_goal):

    title = tmp_goal.title = "title"
    description = tmp_goal.description = "description"
    remote_code = tmp_goal.remote_code = "remote_code"
    imported_on = tmp_goal.imported_on = datetime.now()

    assert goal_repo.update(tmp_goal) == 1

    obj_out = goal_repo.get_one(id=tmp_goal.id)
    assert tmp_goal == obj_out
    assert obj_out.title == title
    assert obj_out.description == description
    assert obj_out.remote_code == remote_code
    assert obj_out.imported_on == imported_on


def test_upsert_delete(goal_repo):
    # create
    goal = Goal(title="test_upsert_delete")
    obj_out = goal_repo.upsert(goal)
    # TODO: Если убрать айдишники под капот (в Л2, в схемы в репах), то тут их не будет
    goal.id = obj_out.id
    assert goal_repo.upsert(goal) == goal

    # update
    goal.description = "description"
    assert goal_repo.upsert(goal) == goal

    # delete
    assert goal_repo.delete(goal) == 1
