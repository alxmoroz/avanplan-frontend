#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends
from pydantic import HttpUrl
from sqlalchemy.orm import Session

from lib.L1_domain.entities.api import Msg
from lib.L1_domain.usecases.import_uc import ImportUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories import GoalRepo, ImportRedmineRepo, MilestoneRepo, PersonRepo, TaskPriorityRepo, TaskRepo, TaskStatusRepo
from lib.L3_app.api.v1.users import user_uc

router = APIRouter(prefix="/import/redmine")


def _import_uc(
    host: HttpUrl = Body(None),  # Redmine host
    api_key: str = Body(None),  # API key
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> ImportUC:

    uc.get_active_user()

    return ImportUC(
        import_repo=ImportRedmineRepo(host=host, api_key=api_key),
        goal_repo=GoalRepo(db),
        task_repo=TaskRepo(db),
        task_status_repo=TaskStatusRepo(db),
        task_priority_repo=TaskPriorityRepo(db),
        person_repo=PersonRepo(db),
        milestone_repo=MilestoneRepo(db),
    )


@router.post("/goals", response_model=Msg)
def goals(uc: ImportUC = Depends(_import_uc)) -> Msg:
    return uc.import_goals()


@router.post("/tasks", response_model=Msg)
def tasks(uc: ImportUC = Depends(_import_uc)) -> Msg:
    return uc.import_tasks()
