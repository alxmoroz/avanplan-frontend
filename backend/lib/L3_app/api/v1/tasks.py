#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Task
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L2_data.mappers import TaskMapper
from lib.L2_data.repositories import db as dbr
from lib.L2_data.schema import TaskSchemaGet, TaskSchemaUpsert

from .auth.auth import auth_db
from .task_statuses import router as statuses_router

router = APIRouter(prefix="/tasks")
router.include_router(statuses_router)


def _tasks_uc(
    db: Session = Depends(auth_db),
) -> BaseDBUC:
    return BaseDBUC(
        repo=dbr.TaskRepo(db),
        mapper=TaskMapper(),
    )


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
