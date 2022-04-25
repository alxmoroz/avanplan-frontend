#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities import TaskStatus
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L2_data.mappers import TaskStatusMapper
from lib.L2_data.repositories import db as dbr
from lib.L2_data.schema import TaskStatusSchemaGet

from .auth import db_organization

router = APIRouter(prefix="/statuses")


def _task_statuses_uc(
    db: Session = Depends(db_organization),
) -> BaseDBUC:
    return BaseDBUC(
        db_repo=dbr.TaskStatusRepo(db),
        e_repo=TaskStatusMapper(),
    )


@router.get("/", response_model=list[TaskStatusSchemaGet])
def get_task_statuses(
    uc: BaseDBUC = Depends(_task_statuses_uc),
) -> list[TaskStatus]:
    return uc.get_all()
