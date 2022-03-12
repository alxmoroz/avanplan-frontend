#  Copyright (c) 2022. Alexandr Moroz

import pytest
from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session

from lib.L2_data.models import Goal, Person, Task, TaskStatus
from lib.L2_data.repositories.db import GoalRepo, PersonRepo, TaskRepo, TaskStatusRepo
from lib.L2_data.schema import GoalSchemaCreate, PersonSchemaCreate, TaskSchemaCreate, TaskStatusSchema


@pytest.fixture(scope="session")
def goal_repo(db: Session) -> GoalRepo:
    yield GoalRepo(db)


@pytest.fixture(scope="session")
def tmp_goal(goal_repo) -> Goal:
    s = GoalSchemaCreate(title="tmp_goal")
    goal = goal_repo.update(jsonable_encoder(s))
    yield goal
    goal_repo.delete(goal.id)


@pytest.fixture(scope="session")
def task_repo(db) -> TaskRepo:
    yield TaskRepo(db)


@pytest.fixture(scope="session")
def task_status_repo(db) -> TaskStatusRepo:
    yield TaskStatusRepo(db)


@pytest.fixture(scope="session")
def tmp_task_status(task_status_repo: TaskStatusRepo) -> TaskStatus:
    s = TaskStatusSchema(title="tmp_task_status")
    ts = task_status_repo.update(jsonable_encoder(s))
    yield ts
    task_status_repo.delete(ts.id)


@pytest.fixture(scope="session")
def tmp_task(task_repo, tmp_goal, tmp_task_status) -> Task:
    s = TaskSchemaCreate(title="tmp_task", goal_id=tmp_goal.id, status_id=tmp_task_status.id)
    task = task_repo.update(jsonable_encoder(s))
    yield task
    task_repo.delete(task.id)


@pytest.fixture(scope="session")
def person_repo(db) -> PersonRepo:
    yield PersonRepo(db)


@pytest.fixture(scope="session")
def tmp_person(person_repo) -> Person:
    s = PersonSchemaCreate(firstname="tmp_person")
    person = person_repo.update(jsonable_encoder(s))
    yield person
    person_repo.delete(person.id)
