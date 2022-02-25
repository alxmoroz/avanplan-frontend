#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

import pytest
from sqlalchemy import column

from lib.L1_domain.entities.tracker import Milestone
from lib.L2_data.repositories import MilestoneRepo


def test_get_one(milestone_repo, tmp_milestone):
    obj_out = milestone_repo.get_one(id=tmp_milestone.id)
    assert tmp_milestone == obj_out


def test_get(milestone_repo, tmp_milestone, tmp_project):

    t2 = milestone_repo.create(Milestone(title="test_get", project_id=tmp_project.id))

    objects = milestone_repo.get(
        limit=2,
        where=column("id").in_([tmp_milestone.id, t2.id]),
    )
    assert tmp_milestone in objects
    assert t2 in objects
    assert len(objects) == 2


def test_create(milestone_repo, tmp_milestone):
    obj_out = milestone_repo.get_one(id=tmp_milestone.id)
    assert tmp_milestone == obj_out


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


def test_upsert_delete(milestone_repo, tmp_project):
    # create
    m = Milestone(title="test_upsert_delete", project_id=tmp_project.id)
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
def tmp_milestone(milestone_repo, tmp_project) -> Milestone:
    milestone = milestone_repo.upsert(Milestone(title="tmp_task_status", project_id=tmp_project.id))
    yield milestone
    milestone_repo.delete(milestone)
