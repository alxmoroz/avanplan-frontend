#  Copyright (c) 2022. Alexandr Moroz

import pytest
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Goal, Person, Task
from lib.L2_data.repositories import GoalRepo, PersonRepo, TaskRepo


@pytest.fixture(scope="module")
def goal_repo(db: Session) -> GoalRepo:
    yield GoalRepo(db)


@pytest.fixture(scope="module")
def tmp_goal(goal_repo) -> Goal:
    goal = goal_repo.upsert(Goal(title="tmp_goal"))
    yield goal
    goal_repo.delete(goal.id)


@pytest.fixture(scope="module")
def task_repo(db) -> TaskRepo:
    yield TaskRepo(db)


@pytest.fixture(scope="module")
def tmp_task(task_repo, tmp_goal) -> Task:
    task = task_repo.upsert(Task(title="tmp_task", goal=tmp_goal))
    yield task
    task_repo.delete(task.id)


@pytest.fixture(scope="module")
def person_repo(db) -> PersonRepo:
    yield PersonRepo(db)


@pytest.fixture(scope="module")
def tmp_person(person_repo) -> Person:
    person = person_repo.upsert(Person(firstname="tmp_person"))
    yield person
    person_repo.delete(person.id)
