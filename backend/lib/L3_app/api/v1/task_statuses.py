#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities import TaskStatus
from lib.L1_domain.usecases.smart_uc import SmartUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories import db as dbr
from lib.L2_data.repositories import entities as er
from lib.L2_data.schema import TaskStatusSchemaGet
from lib.L3_app.api.v1.users import user_uc

router = APIRouter(prefix="/statuses")


def _task_statuses_uc(
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> SmartUC:
    uc.get_active_user()
    return SmartUC(
        db_repo=dbr.TaskStatusRepo(db),
        e_repo=er.TaskStatusRepo(),
    )


@router.get("/", response_model=list[TaskStatusSchemaGet])
def get_task_statuses(
    uc: SmartUC = Depends(_task_statuses_uc),
) -> list[TaskStatus]:
    return uc.get_all()
