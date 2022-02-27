#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Goal
from lib.L1_domain.usecases.goals_uc import GoalsUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories.db.goals import GoalRepo, TaskRepo
from lib.L3_app.api.v1.users import user_uc

router = APIRouter(prefix="/goals")


def _goals_uc(
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> GoalsUC:
    uc.get_active_user()
    return GoalsUC(goal_repo=GoalRepo(db), task_repo=TaskRepo(db))


@router.get("/", response_model=list[Goal])
def goals(uc: GoalsUC = Depends(_goals_uc)) -> list[Goal]:

    return uc.get_goals()


@router.get("/{goal_id}", response_model=Goal)
def goal(goal_id: int, uc: GoalsUC = Depends(_goals_uc)) -> Goal:

    return uc.get_goal(goal_id=goal_id)
