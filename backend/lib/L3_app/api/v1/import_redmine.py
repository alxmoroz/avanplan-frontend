#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends
from pydantic import HttpUrl
from sqlalchemy.orm import Session

from lib.L1_domain.entities.api import Msg
from lib.L1_domain.usecases.import_uc import ImportUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories import db as dbr
from lib.L2_data.repositories import entities as er
from lib.L2_data.repositories.integrations import ImportRedmineRepo
from lib.L3_app.api.v1.users import user_uc

router = APIRouter(prefix="/integrations/redmine")


def _import_uc(
    host: HttpUrl = Body(None),  # Redmine host
    api_key: str = Body(None),  # API key
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> ImportUC:

    uc.get_active_user()

    return ImportUC(
        import_repo=ImportRedmineRepo(host=host, api_key=api_key),
        goal_repo=dbr.GoalRepo(db),
        goal_e_repo=er.GoalImportRepo(),
        task_repo=dbr.TaskRepo(db),
        task_e_repo=er.TaskImportRepo(),
        task_status_repo=dbr.TaskStatusRepo(db),
        task_status_e_repo=er.TaskStatusRepo(),
        task_priority_repo=dbr.TaskPriorityRepo(db),
        task_priority_e_repo=er.TaskPriorityRepo(),
        person_repo=dbr.PersonRepo(db),
        person_e_repo=er.PersonRepo(),
    )


@router.post("/goals", response_model=Msg)
def goals(uc: ImportUC = Depends(_import_uc)) -> Msg:
    return uc.import_goals()


# @router.post("/tasks", response_model=Msg)
# def tasks(uc: ImportUC = Depends(_import_uc)) -> Msg:
#     return uc.import_tasks()
