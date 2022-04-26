#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Goal
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L2_data.mappers import GoalMapper
from lib.L2_data.repositories import db as dbr
from lib.L2_data.schema import GoalSchemaGet, GoalSchemaUpsert

from .auth import auth_db
from .goal_statuses import router as statuses_router

router = APIRouter(prefix="/goals")
router.include_router(statuses_router)


def _goals_uc(
    db: Session = Depends(auth_db),
) -> BaseDBUC:

    return BaseDBUC(
        db_repo=dbr.GoalRepo(db),
        e_repo=GoalMapper(),
    )


@router.get("/", response_model=list[GoalSchemaGet])
def get_goals(
    uc: BaseDBUC = Depends(_goals_uc),
) -> list[Goal]:
    return uc.get_all()


@router.post("/", response_model=GoalSchemaGet, status_code=201)
def upsert_goal(
    goal: GoalSchemaUpsert,
    uc: BaseDBUC = Depends(_goals_uc),
) -> Goal:

    return uc.upsert(goal)


@router.delete("/{goal_id}")
def delete_goal(
    goal_id: int,
    uc: BaseDBUC = Depends(_goals_uc),
) -> int:

    return uc.delete(goal_id)
