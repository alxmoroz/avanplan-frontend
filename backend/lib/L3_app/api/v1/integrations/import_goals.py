#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities import GoalImport, RemoteTracker
from lib.L1_domain.entities.api import Msg
from lib.L1_domain.entities.api.exceptions import ApiException
from lib.L1_domain.repositories import AbstractImportRepo
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L1_domain.usecases.import_uc import ImportUC
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.mappers import GoalImportMapper, PersonMapper, TaskImportMapper, TaskPriorityMapper, TaskStatusMapper
from lib.L2_data.repositories import db as dbr
from lib.L2_data.repositories.integrations import ImportRedmineRepo
from lib.L2_data.schema.goals.goal import GoalSchema
from lib.L3_app.api.v1.users import user_uc

from .remote_trackers import remote_trackers_uc

router = APIRouter(prefix="/goals", tags=["integrations - goals"])


def _import_uc(
    tracker_id: int,
    tracker_uc: BaseDBUC = Depends(remote_trackers_uc),
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> ImportUC:
    uc.get_active_user()

    repo: AbstractImportRepo | None = None
    tracker: RemoteTracker = tracker_uc.get_one(id=tracker_id)

    if tracker.type.title == "Redmine":
        # TODO: добавить вариант с обычной авторизацией
        repo = ImportRedmineRepo(host=tracker.url, api_key=tracker.login_key)

    if not repo:
        raise ApiException(500, "Tracker not found")

    return ImportUC(
        import_repo=repo,
        goal_repo=dbr.GoalRepo(db),
        goal_e_repo=GoalImportMapper(),
        task_repo=dbr.TaskRepo(db),
        task_e_repo=TaskImportMapper(),
        task_status_repo=dbr.TaskStatusRepo(db),
        task_status_e_repo=TaskStatusMapper(),
        task_priority_repo=dbr.TaskPriorityRepo(db),
        task_priority_e_repo=TaskPriorityMapper(),
        person_repo=dbr.PersonRepo(db),
        person_e_repo=PersonMapper(),
    )


@router.get("/", response_model=list[GoalSchema])
def get_goals(
    uc: ImportUC = Depends(_import_uc),
) -> list[GoalImport]:
    return uc.get_goals()


@router.post("/import", response_model=Msg)
def import_goals(
    uc: ImportUC = Depends(_import_uc),
) -> Msg:
    return uc.import_goals()


# @router.post("/tasks", response_model=Msg)
# def tasks(uc: ImportUC = Depends(_import_uc)) -> Msg:
#     return uc.import_tasks()
