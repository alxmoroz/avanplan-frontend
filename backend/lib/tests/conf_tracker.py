#  Copyright (c) 2022. Alexandr Moroz

import pytest
from sqlalchemy.orm import Session

from lib.L2_data.repositories import PersonRepo, ProjectRepo, TaskRepo


@pytest.fixture(scope="module")
def project_repo(db: Session) -> ProjectRepo:
    yield ProjectRepo(db)


@pytest.fixture(scope="module")
def task_repo(db) -> TaskRepo:
    yield TaskRepo(db)


@pytest.fixture(scope="module")
def person_repo(db) -> PersonRepo:
    yield PersonRepo(db)
