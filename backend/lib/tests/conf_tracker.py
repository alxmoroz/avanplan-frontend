#  Copyright (c) 2022. Alexandr Moroz

import pytest
from sqlalchemy.orm import Session

from lib.L1_domain.entities.tracker import Project, Task
from lib.L2_data.repositories import PersonRepo, ProjectRepo, TaskRepo


@pytest.fixture(scope="module")
def project_repo(db: Session) -> ProjectRepo:
    yield ProjectRepo(db)


@pytest.fixture(scope="module")
def tmp_project(project_repo) -> Project:
    project = project_repo.upsert(Project(title="tmp_project"))
    yield project
    project_repo.delete(project)


@pytest.fixture(scope="module")
def task_repo(db) -> TaskRepo:
    yield TaskRepo(db)


@pytest.fixture(scope="module")
def tmp_task(task_repo, tmp_project) -> Task:
    task = task_repo.upsert(Task(title="tmp_task", project_id=tmp_project.id))
    yield task
    task_repo.delete(task)


@pytest.fixture(scope="module")
def person_repo(db) -> PersonRepo:
    yield PersonRepo(db)
