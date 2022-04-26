#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities import GoalStatus
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L2_data.mappers import GoalStatusMapper
from lib.L2_data.repositories import db as dbr
from lib.L2_data.schema import GoalStatusSchemaGet

from .auth import auth_db

router = APIRouter(prefix="/statuses")


def _goal_statuses_uc(
    db: Session = Depends(auth_db),
) -> BaseDBUC:
    return BaseDBUC(
        db_repo=dbr.GoalStatusRepo(db),
        e_repo=GoalStatusMapper(),
    )


@router.get("/", response_model=list[GoalStatusSchemaGet])
def get_goals_statuses(
    uc: BaseDBUC = Depends(_goal_statuses_uc),
) -> list[GoalStatus]:
    return uc.get_all()
