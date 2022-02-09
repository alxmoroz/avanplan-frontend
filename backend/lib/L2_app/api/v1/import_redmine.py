#  Copyright (c) 2022. Alexandr Moroz
from datetime import datetime

from fastapi import APIRouter, Body, Depends
from redminelib import Redmine, resources
from sqlalchemy.orm import Session

from lib.L1_domain.entities import api
from lib.L1_domain.entities.tracker.project import Project
from lib.L1_domain.entities.tracker.task import Task, TaskPriority, TaskStatus
from lib.L2_app.api import deps
from lib.L3_data.models.tracker.project import Project as ProjectModel
from lib.L3_data.repositories import project_repo

router = APIRouter()


@router.post("/tasks", response_model=api.Msg)
def tasks(
    host: str = Body(None),  # Redmine host
    api_key: str = Body(None),  # API key
    version: str | None = Body(None),
    granted: bool = Depends(deps.is_active_user),  # noqa
    db: Session = Depends(deps.get_db),
) -> any:
    r = Redmine(host, key=api_key, version=version)
    r_opened_projects: list[resources.Project] = r.project.all()
    r_opened_issues: list[resources.Issue] = r.issue.filter(status_id="open")

    # TODO: попахивает мапперами)
    for rp in r_opened_projects:
        p = Project(
            code=rp.identifier,
            title=rp.name,
            description=rp.description,
            remote_code=f"R{rp.id}",
            imported_on=datetime.now(),
        )

        p_in_db = db.query(ProjectModel).filter(ProjectModel.code == p.code).first()
        if p_in_db:
            project_repo.update(db, db_obj=p_in_db, obj_in=p)
        else:
            project_repo.create(db, obj_in=p)

    for issue in r_opened_issues:
        t = Task(
            code=issue.id,
            remote_code=f"R{issue.id}",
            title=issue.subject,
            priority=TaskPriority(code=issue.priority.name),
            status=TaskStatus(code=issue.status.name),
            description=issue.description,
        )

    # TODO: проставить связи

    # TODO: запись в БД

    # print("\n".join([str(list(p)) for p in projects]))
    # print(list(tasks))

    return {"msg": f"Issues from Redmine {host} imported successful\n"}
