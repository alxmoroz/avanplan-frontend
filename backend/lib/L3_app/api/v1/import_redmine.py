#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends, HTTPException
from pydantic import HttpUrl
from sqlalchemy.orm import Session

from lib.L1_domain.entities.api import Msg
from lib.L1_domain.entities.tracker import Project, Task
from lib.L1_domain.usecases.import_uc import ImportUseCase
from lib.L2_data.db import db_session
from lib.L2_data.models import Project as ProjectModel
from lib.L2_data.models import Task as TaskModel
from lib.L2_data.repositories import DBRepo, RedmineImportRepo
from lib.L3_app.api import deps

router = APIRouter(prefix="/import/redmine")


# TODO: можно хранить настройки соединений отдельно и не брать каждый раз с фронта


@router.post("/tasks", response_model=Msg)
def tasks(
    host: HttpUrl = Body(None),  # Redmine host
    api_key: str = Body(None),  # API key
    version: str | None = Body(None),
    user=Depends(deps.get_current_active_user),  # noqa
    db: Session = Depends(db_session),
) -> Msg:

    if not host or not api_key:
        raise HTTPException(status_code=400, detail="Host and API-key must be filled")

    return ImportUseCase(
        import_repo=RedmineImportRepo(host=host, api_key=api_key, version=version),
        project_repo=DBRepo(ProjectModel, Project, db),
        task_repo=DBRepo(TaskModel, Task, db),
    ).import_redmine()
