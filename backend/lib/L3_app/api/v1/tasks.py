#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Task
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.mappers import TaskMapper
from lib.L2_data.repositories import db as dbr
from lib.L2_data.schema import TaskSchemaGet, TaskSchemaUpsert
from lib.L3_app.api.v1.users import user_uc

from .task_statuses import router as statuses_router

router = APIRouter(prefix="/tasks")
router.include_router(statuses_router)


def _tasks_uc(
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> BaseDBUC:
    uc.get_active_user()
    return BaseDBUC(
        db_repo=dbr.TaskRepo(db),
        e_repo=TaskMapper(),
    )


# @integrations_router.get("/", response_model=list[TaskSchemaGet])
# def get_tasks(
#     uc: TasksUC = Depends(_tasks_uc),
# ) -> list[Task]:
#     return uc.get_tasks()


@router.post("/", response_model=TaskSchemaGet, status_code=201)
def upsert_task(
    task: TaskSchemaUpsert,
    uc: BaseDBUC = Depends(_tasks_uc),
) -> Task:

    return uc.upsert(task)


@router.delete("/{task_id}")
def delete_task(
    task_id: int,
    uc: BaseDBUC = Depends(_tasks_uc),
) -> int:

    return uc.delete(task_id)
