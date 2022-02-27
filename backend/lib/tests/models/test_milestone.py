#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

import pytest
from sqlalchemy import column

from lib.L1_domain.entities.goals import Milestone
from lib.L2_data.repositories import MilestoneRepo


def test_get_one(milestone_repo, tmp_milestone):
    obj_out = milestone_repo.get_one(id=tmp_milestone.id)
    assert tmp_milestone == obj_out


def test_get_create(milestone_repo, tmp_milestone, tmp_goal):

    obj2 = milestone_repo.create(Milestone(title="test_get", goal=tmp_goal))

    objects = milestone_repo.get(
        limit=2,
        where=column("id").in_([tmp_milestone.id, obj2.id]),
    )
    assert tmp_milestone in objects
    assert obj2 in objects
    assert len(objects) == 2


# TODO: ещё нужно добавить проверку изменения для всех связанных объектов (айдишников)
def test_update(milestone_repo, tmp_milestone):
    title = tmp_milestone.title = "title"
    description = tmp_milestone.description = "description"
    remote_code = tmp_milestone.remote_code = "remote_code"
    imported_on = tmp_milestone.imported_on = datetime.now()
    start_date = tmp_milestone.start_date = datetime.now()
    due_date = tmp_milestone.due_date = datetime.now()
    assert milestone_repo.update(tmp_milestone) == 1

    obj_out = milestone_repo.get_one(id=tmp_milestone.id)
    assert tmp_milestone == obj_out
    assert obj_out.title == title
    assert obj_out.description == description
    assert obj_out.remote_code == remote_code
    assert obj_out.imported_on == imported_on
    assert obj_out.start_date == start_date
    assert obj_out.due_date == due_date


def test_upsert_delete(milestone_repo, tmp_goal):
    # create
    m = Milestone(title="test_upsert_delete", goal=tmp_goal)
    obj_out = milestone_repo.upsert(m)
    # TODO: Если убрать айдишники под капот (в Л2, в схемы в репах), то тут их не будет
    m.id = obj_out.id
    assert milestone_repo.upsert(m) == m

    # update
    m.description = "description"
    assert milestone_repo.upsert(m) == m

    # delete
    assert milestone_repo.delete(m) == 1


@pytest.fixture(scope="module")
def milestone_repo(db) -> MilestoneRepo:
    yield MilestoneRepo(db)


@pytest.fixture(scope="module")
def tmp_milestone(milestone_repo, tmp_goal) -> Milestone:
    milestone = milestone_repo.upsert(Milestone(title="tmp_task_status", goal=tmp_goal))
    yield milestone
    milestone_repo.delete(milestone)
