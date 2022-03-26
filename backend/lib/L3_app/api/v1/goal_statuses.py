#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities import GoalStatus
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories import db as dbr
from lib.L2_data.repositories import entities as er
from lib.L2_data.schema import GoalStatusSchemaGet
from lib.L3_app.api.v1.users import user_uc

router = APIRouter(prefix="/statuses")


def _goal_statuses_uc(
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> BaseDBUC:
    uc.get_active_user()
    return BaseDBUC(
        db_repo=dbr.GoalStatusRepo(db),
        e_repo=er.GoalStatusRepo(),
    )


@router.get("/", response_model=list[GoalStatusSchemaGet])
def get_goals_statuses(
    uc: BaseDBUC = Depends(_goal_statuses_uc),
) -> list[GoalStatus]:
    return uc.get_all()
