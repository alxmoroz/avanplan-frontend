#  Copyright (c) 2022. Alexandr Moroz

import pytest
from fastapi.encoders import jsonable_encoder
from pydantic import EmailStr, HttpUrl
from sqlalchemy.orm import Session

from lib.L2_data.models import Goal, Person, RemoteTracker, RemoteTrackerType, Task, TaskStatus
from lib.L2_data.repositories.db import GoalRepo, PersonRepo, RemoteTrackerRepo, RemoteTrackerTypeRepo, TaskRepo, TaskStatusRepo
from lib.L2_data.schema import (
    GoalSchemaUpsert,
    PersonSchemaUpsert,
    RemoteTrackerSchemaUpsert,
    RemoteTrackerTypeSchemaUpsert,
    TaskSchemaUpsert,
    TaskStatusSchemaUpsert,
)


@pytest.fixture(scope="session")
def goal_repo(db: Session) -> GoalRepo:
    yield GoalRepo(db)


@pytest.fixture(scope="session")
def tmp_goal(goal_repo) -> Goal:
    s = GoalSchemaUpsert(title="tmp_goal", closed=False)
    goal = goal_repo.upsert(jsonable_encoder(s))
    yield goal
    goal_repo.delete(goal.id)


@pytest.fixture(scope="session")
def remote_tracker_type_repo(db) -> RemoteTrackerTypeRepo:
    yield RemoteTrackerTypeRepo(db)


@pytest.fixture(scope="session")
def tmp_remote_tracker_type(remote_tracker_type_repo: RemoteTrackerTypeRepo) -> RemoteTrackerType:
    s = RemoteTrackerTypeSchemaUpsert(title="tmp_remote_tracker_type")
    tt = remote_tracker_type_repo.upsert(jsonable_encoder(s))
    yield tt
    remote_tracker_type_repo.delete(tt.id)


@pytest.fixture(scope="session")
def remote_tracker_repo(db) -> RemoteTrackerRepo:
    yield RemoteTrackerRepo(db)


@pytest.fixture(scope="session")
def tmp_remote_tracker(remote_tracker_repo: RemoteTrackerRepo, tmp_remote_tracker_type) -> RemoteTracker:
    s = RemoteTrackerSchemaUpsert(
        description="tmp_remote_tracker",
        remote_tracker_type_id=tmp_remote_tracker_type.id,
        url=HttpUrl("https://tmp_remote_tracker.test", scheme="https"),
        login_key="login",
    )
    tr = remote_tracker_repo.upsert(jsonable_encoder(s))
    yield tr
    remote_tracker_repo.delete(tr.id)


@pytest.fixture(scope="session")
def task_status_repo(db) -> TaskStatusRepo:
    yield TaskStatusRepo(db)


@pytest.fixture(scope="session")
def tmp_task_status(task_status_repo: TaskStatusRepo) -> TaskStatus:
    s = TaskStatusSchemaUpsert(title="tmp_task_status", closed=False)
    ts = task_status_repo.upsert(jsonable_encoder(s))
    yield ts
    task_status_repo.delete(ts.id)


@pytest.fixture(scope="session")
def task_repo(db) -> TaskRepo:
    yield TaskRepo(db)


@pytest.fixture(scope="session")
def tmp_task(task_repo, tmp_goal, tmp_task_status) -> Task:
    s = TaskSchemaUpsert(title="tmp_task", goal_id=tmp_goal.id, status_id=tmp_task_status.id, closed=False)
    task = task_repo.upsert(jsonable_encoder(s))
    yield task
    task_repo.delete(task.id)


@pytest.fixture(scope="session")
def person_repo(db) -> PersonRepo:
    yield PersonRepo(db)


@pytest.fixture(scope="session")
def tmp_person(person_repo) -> Person:
    s = PersonSchemaUpsert(firstname="tmp_person", email=EmailStr("tmp_person@mail.com"))
    person = person_repo.upsert(jsonable_encoder(s))
    yield person
    person_repo.delete(person.id)
