#  Copyright (c) 2022. Alexandr Moroz

import pytest
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Goal, Person, Task, TaskStatus
from lib.L2_data.repositories.db import GoalRepo, PersonRepo, TaskRepo, TaskStatusRepo
from lib.L2_data.schema import GoalSchemaCreate, PersonSchemaCreate, TaskSchemaCreate, TaskStatusSchema


@pytest.fixture(scope="session")
def goal_repo(db: Session) -> GoalRepo:
    yield GoalRepo(db)


@pytest.fixture(scope="session")
def tmp_goal(goal_repo) -> Goal:
    goal = goal_repo.update(GoalSchemaCreate(title="tmp_goal"))
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
    ts = task_status_repo.update(TaskStatusSchema(title="tmp_task_status"))
    yield ts
    task_status_repo.delete(ts.id)


@pytest.fixture(scope="session")
def tmp_task(task_repo, tmp_goal, tmp_task_status) -> Task:
    task = task_repo.update(TaskSchemaCreate(title="tmp_task", goal_id=tmp_goal.id, status_id=tmp_task_status.id))
    yield task
    task_repo.delete(task.id)


@pytest.fixture(scope="session")
def person_repo(db) -> PersonRepo:
    yield PersonRepo(db)


@pytest.fixture(scope="session")
def tmp_person(person_repo) -> Person:
    person = person_repo.update(PersonSchemaCreate(firstname="tmp_person"))
    yield person
    person_repo.delete(person.id)
