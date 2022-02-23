#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends
from pydantic import HttpUrl
from sqlalchemy.orm import Session

from lib.L1_domain.entities.api import Msg
from lib.L1_domain.usecases.import_uc import ImportUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories import PersonRepo, ProjectRepo, RedmineImportRepo, TaskPriorityRepo, TaskRepo, TaskStatusRepo
from lib.L3_app.api.v1.users import user_uc

router = APIRouter(prefix="/import/redmine")

# TODO: можно хранить настройки соединений отдельно и не брать каждый раз с фронта


@router.post("/tasks", response_model=Msg)
def tasks(
    host: HttpUrl = Body(None),  # Redmine host
    api_key: str = Body(None),  # API key
    version: str | None = Body(None),
    db: Session = Depends(db_session),
    uc: UsersUC = Depends(user_uc),
) -> Msg:

    uc.get_active_user()

    return ImportUC(
        import_repo=RedmineImportRepo(host=host, api_key=api_key, version=version),
        project_repo=ProjectRepo(db),
        task_repo=TaskRepo(db),
        task_status_repo=TaskStatusRepo(db),
        task_priority_repo=TaskPriorityRepo(db),
        person_repo=PersonRepo(db),
    ).import_tasks()
