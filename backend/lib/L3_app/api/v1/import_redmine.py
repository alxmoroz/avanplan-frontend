#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends
from pydantic import HttpUrl
from sqlalchemy.orm import Session

from lib.L1_domain.entities.api import Msg
from lib.L1_domain.entities.tracker import Project, Task
from lib.L1_domain.usecases.import_uc import ImportUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.models import Project as ProjectModel
from lib.L2_data.models import Task as TaskModel
from lib.L2_data.repositories import DBRepo, RedmineImportRepo, SecurityRepo, UserRepo
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

    UsersUC(UserRepo(db), SecurityRepo(token)).get_active_user()

    return ImportUC(
        import_repo=RedmineImportRepo(host=host, api_key=api_key, version=version),
        project_repo=DBRepo(ProjectModel, Project, db),
        task_repo=DBRepo(TaskModel, Task, db),
    ).import_redmine()
