#  Copyright (c) 2022. Alexandr Moroz

from contextlib import contextmanager
from datetime import datetime
from typing import Generator

import pytest
from sqlalchemy import column
from sqlalchemy.orm import Session

from lib.L1_domain.entities.tracker import Project
from lib.L2_data.repositories import ProjectRepo
from lib.tests.utils import random_lower_string


def test_get_obj(project_repo):
    with tmp_object(project_repo) as obj:
        obj_out = project_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_get_objects(project_repo):
    with tmp_object(project_repo) as o1, tmp_object(project_repo) as o2:
        objects = project_repo.get(
            limit=2,
            where=column("id").in_([o1.id, o2.id]),
        )
        assert o1 in objects
        assert o2 in objects
        assert len(objects) == 2


def test_create_object(project_repo):
    with tmp_object(project_repo) as obj:
        obj_out = project_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_update_object(project_repo):
    with tmp_object(project_repo) as obj_in:
        title = obj_in.title = "title"
        description = obj_in.description = "description"
        remote_code = obj_in.remote_code = "remote_code"
        imported_on = obj_in.imported_on = datetime.now()

        assert project_repo.update(obj_in) == 1

        obj_out = project_repo.get_one(id=obj_in.id)
        assert obj_in == obj_out
        assert obj_out.title == title
        assert obj_out.description == description
        assert obj_out.remote_code == remote_code
        assert obj_out.imported_on == imported_on


def test_delete_project(project_repo):
    with tmp_object(project_repo) as obj:
        assert project_repo.delete(obj) == 1


@pytest.fixture(scope="module")
def project_repo(db: Session) -> ProjectRepo:
    yield ProjectRepo(db)


@contextmanager
def tmp_object(project_repo) -> Generator:
    project: Project | None = None
    try:
        project = project_repo.create(Project(title=random_lower_string()))
        yield project
    finally:
        project_repo.delete(project)
