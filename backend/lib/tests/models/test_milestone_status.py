#  Copyright (c) 2022. Alexandr Moroz


import pytest
from sqlalchemy import column

from lib.L1_domain.entities.tracker import MilestoneStatus
from lib.L2_data.repositories import MilestoneStatusRepo


def test_get_one(milestone_status_repo, tmp_milestone_status):
    obj_out = milestone_status_repo.get_one(id=tmp_milestone_status.id)
    assert tmp_milestone_status == obj_out


def test_get(milestone_status_repo, tmp_milestone_status):

    t2 = milestone_status_repo.create(MilestoneStatus(title="test_get"))

    objects = milestone_status_repo.get(
        limit=2,
        where=column("id").in_([tmp_milestone_status.id, t2.id]),
    )
    assert tmp_milestone_status in objects
    assert t2 in objects
    assert len(objects) == 2

    assert milestone_status_repo.delete(t2) == 1


def test_create(milestone_status_repo, tmp_milestone_status):
    obj_out = milestone_status_repo.get_one(id=tmp_milestone_status.id)
    assert tmp_milestone_status == obj_out


def test_update(milestone_status_repo, tmp_milestone_status):
    title = tmp_milestone_status.title = "title"
    description = tmp_milestone_status.description = "description"
    closed = tmp_milestone_status.closed = True
    assert milestone_status_repo.update(tmp_milestone_status) == 1

    obj_out = milestone_status_repo.get_one(id=tmp_milestone_status.id)
    assert tmp_milestone_status == obj_out
    assert obj_out.title == title
    assert obj_out.description == description
    assert obj_out.closed == closed


def test_upsert_delete(milestone_status_repo):
    # create
    milestone_status = MilestoneStatus(title="test_upsert_delete")
    assert milestone_status_repo.upsert(milestone_status) == milestone_status

    # update
    milestone_status.description = "description"
    assert milestone_status_repo.upsert(milestone_status) == milestone_status

    # delete
    assert milestone_status_repo.delete(milestone_status) == 1


@pytest.fixture(scope="module")
def milestone_status_repo(db) -> MilestoneStatusRepo:
    yield MilestoneStatusRepo(db)


@pytest.fixture(scope="module")
def tmp_milestone_status(milestone_status_repo) -> MilestoneStatus:
    milestone_status = milestone_status_repo.upsert(MilestoneStatus(title="tmp_milestone_status"))
    yield milestone_status
    milestone_status_repo.delete(milestone_status)
