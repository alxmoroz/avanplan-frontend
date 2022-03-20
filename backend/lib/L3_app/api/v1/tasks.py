#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Task
from lib.L1_domain.usecases.tasks_uc import TasksUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories import db as dbr
from lib.L2_data.repositories import entities as er
from lib.L2_data.schema import TaskSchemaGet, TaskSchemaUpsert
from lib.L3_app.api.v1.users import user_uc

router = APIRouter(prefix="/tasks")


def _tasks_uc(
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> TasksUC:
    uc.get_active_user()
    return TasksUC(
        task_db_repo=dbr.TaskRepo(db),
        task_e_repo=er.TaskRepo(),
    )


# @router.get("/", response_model=list[TaskSchemaGet])
# def get_tasks(
#     uc: TasksUC = Depends(_tasks_uc),
# ) -> list[Task]:
#     return uc.get_tasks()


@router.post("/", response_model=TaskSchemaGet, status_code=201)
def upsert_task(
    task: TaskSchemaUpsert,
    uc: TasksUC = Depends(_tasks_uc),
) -> Task:

    return uc.upsert_task(task)


@router.delete("/{task_id}")
def delete_task(
    task_id: int,
    uc: TasksUC = Depends(_tasks_uc),
) -> int:

    return uc.delete_task(task_id)
