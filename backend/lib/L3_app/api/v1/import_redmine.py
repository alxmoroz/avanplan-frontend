#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends
from pydantic import HttpUrl
from sqlalchemy.orm import Session

from lib.L1_domain.entities.api import Msg
from lib.L1_domain.usecases.import_uc import ImportUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories import ProjectRepo, RedmineImportRepo, SecurityRepo, TaskRepo, UserRepo
from lib.L2_data.repositories.db_repo import TaskStatusRepo
from lib.L2_data.repositories.security_repo import oauth2_scheme

router = APIRouter(prefix="/import/redmine")

# TODO: можно хранить настройки соединений отдельно и не брать каждый раз с фронта


@router.post("/tasks", response_model=Msg)
def tasks(
    host: HttpUrl = Body(None),  # Redmine host
    api_key: str = Body(None),  # API key
    version: str | None = Body(None),
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(db_session),
) -> Msg:

    # TODO: не очень DRY получилось тут
    UsersUC(UserRepo(db), SecurityRepo(token)).get_active_user()

    return ImportUC(
        import_repo=RedmineImportRepo(host=host, api_key=api_key, version=version),
        project_repo=ProjectRepo(db),
        task_repo=TaskRepo(db),
        task_status_repo=TaskStatusRepo(db),
    ).import_tasks()
