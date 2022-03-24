#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Goal
from lib.L1_domain.usecases.goals_uc import GoalsUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories import db as dbr
from lib.L2_data.repositories import entities as er
from lib.L2_data.schema import GoalSchemaGet, GoalSchemaUpsert
from lib.L3_app.api.v1.users import user_uc

from .goal_statuses import router as statuses_router

router = APIRouter(prefix="/goals")
router.include_router(statuses_router)


def _goals_uc(
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> GoalsUC:
    uc.get_active_user()
    return GoalsUC(
        goal_db_repo=dbr.GoalRepo(db),
        goal_e_repo=er.GoalRepo(),
        task_db_repo=dbr.TaskRepo(db),
        task_e_repo=er.TaskRepo(),
    )


@router.get("/", response_model=list[GoalSchemaGet])
def get_goals(
    uc: GoalsUC = Depends(_goals_uc),
) -> list[Goal]:
    return uc.get_goals()


@router.post("/", response_model=GoalSchemaGet, status_code=201)
def upsert_goal(
    goal: GoalSchemaUpsert,
    uc: GoalsUC = Depends(_goals_uc),
) -> Goal:

    return uc.upsert_goal(goal)


@router.delete("/{goal_id}")
def delete_goal(
    goal_id: int,
    uc: GoalsUC = Depends(_goals_uc),
) -> int:

    return uc.delete_goal(goal_id)
