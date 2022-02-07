#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Body, Depends
from redminelib import Redmine
from sqlalchemy.orm import Session

from lib.L2_app.api.v1 import deps
from lib.L3_data import schemas

router = APIRouter()


@router.post("/issues", response_model=schemas.Msg)
def import_issues(
    host: str = Body(None),  # Redmine host
    api_key: str = Body(None),  # API key
    version: str | None = Body(None),
    granted: bool = Depends(deps.is_active_user),  # noqa
    db: Session = Depends(deps.get_db),
) -> any:
    redmine = Redmine(host, key=api_key, version=version)
    opened_projects = redmine.project.all()
    opened_issues = redmine.issue.filter(status_id="open")

    return {"msg": f"Issues from Redmine {host} imported successful\n"}
