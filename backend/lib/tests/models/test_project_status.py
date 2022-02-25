#  Copyright (c) 2022. Alexandr Moroz


import pytest
from sqlalchemy import column

from lib.L1_domain.entities.tracker import ProjectStatus
from lib.L2_data.repositories import ProjectStatusRepo


def test_get_one(project_status_repo, tmp_project_status):
    obj_out = project_status_repo.get_one(id=tmp_project_status.id)
    assert tmp_project_status == obj_out


def test_get(project_status_repo, tmp_project_status):

    t2 = project_status_repo.create(ProjectStatus(title="test_get"))

    objects = project_status_repo.get(
        limit=2,
        where=column("id").in_([tmp_project_status.id, t2.id]),
    )
    assert tmp_project_status in objects
    assert t2 in objects
    assert len(objects) == 2

    assert project_status_repo.delete(t2) == 1


def test_create(project_status_repo, tmp_project_status):
    obj_out = project_status_repo.get_one(id=tmp_project_status.id)
    assert tmp_project_status == obj_out


def test_update(project_status_repo, tmp_project_status):
    title = tmp_project_status.title = "title"
    description = tmp_project_status.description = "description"
    closed = tmp_project_status.closed = True
    assert project_status_repo.update(tmp_project_status) == 1

    obj_out = project_status_repo.get_one(id=tmp_project_status.id)
    assert tmp_project_status == obj_out
    assert obj_out.title == title
    assert obj_out.description == description
    assert obj_out.closed == closed


def test_upsert_delete(project_status_repo):
    # create
    project_status = ProjectStatus(title="test_upsert_delete")
    assert project_status_repo.upsert(project_status) == project_status

    # update
    project_status.description = "description"
    assert project_status_repo.upsert(project_status) == project_status

    # delete
    assert project_status_repo.delete(project_status) == 1


@pytest.fixture(scope="module")
def project_status_repo(db) -> ProjectStatusRepo:
    yield ProjectStatusRepo(db)


@pytest.fixture(scope="module")
def tmp_project_status(project_status_repo) -> ProjectStatus:
    project_status = project_status_repo.upsert(ProjectStatus(title="tmp_project_status"))
    yield project_status
    project_status_repo.delete(project_status)
