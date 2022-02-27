#  Copyright (c) 2022. Alexandr Moroz


import pytest
from sqlalchemy import column

from lib.L1_domain.entities.goals import GoalStatus
from lib.L2_data.repositories.db.goals.goal_status_repo import GoalStatusRepo


def test_get_one(goal_status_repo, tmp_goal_status):
    obj_out = goal_status_repo.get_one(id=tmp_goal_status.id)
    assert tmp_goal_status == obj_out


def test_get_create(goal_status_repo, tmp_goal_status):

    obj2 = goal_status_repo.create(GoalStatus(title="test_get"))

    objects = goal_status_repo.get(
        limit=2,
        where=column("id").in_([tmp_goal_status.id, obj2.id]),
    )
    assert tmp_goal_status in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert goal_status_repo.delete(obj2) == 1


def test_update(goal_status_repo, tmp_goal_status):
    title = tmp_goal_status.title = "title"
    description = tmp_goal_status.description = "description"
    closed = tmp_goal_status.closed = True
    assert goal_status_repo.update(tmp_goal_status) == 1

    obj_out = goal_status_repo.get_one(id=tmp_goal_status.id)
    assert tmp_goal_status == obj_out
    assert obj_out.title == title
    assert obj_out.description == description
    assert obj_out.closed == closed


def test_upsert_delete(goal_status_repo):
    # create
    goal_status = GoalStatus(title="test_upsert_delete")
    obj_out = goal_status_repo.upsert(goal_status)
    # TODO: Если убрать айдишники под капот (в Л2, в схемы в репах), то тут их не будет
    goal_status.id = obj_out.id
    assert goal_status_repo.upsert(goal_status) == goal_status

    # update
    goal_status.description = "description"
    assert goal_status_repo.upsert(goal_status) == goal_status

    # delete
    assert goal_status_repo.delete(goal_status) == 1


@pytest.fixture(scope="module")
def goal_status_repo(db) -> GoalStatusRepo:
    yield GoalStatusRepo(db)


@pytest.fixture(scope="module")
def tmp_goal_status(goal_status_repo) -> GoalStatus:
    goal_status = goal_status_repo.upsert(GoalStatus(title="tmp_goal_status"))
    yield goal_status
    goal_status_repo.delete(goal_status)
