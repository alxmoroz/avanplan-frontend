#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities import GoalImport, RemoteTracker
from lib.L1_domain.entities.api import Msg
from lib.L1_domain.entities.api.exceptions import ApiException
from lib.L1_domain.repositories import AbstractImportRepo
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L1_domain.usecases.import_uc import ImportUC
from lib.L2_data.mappers import GoalImportMapper, PersonMapper, TaskImportMapper, TaskPriorityMapper, TaskStatusMapper
from lib.L2_data.repositories import db as dbr
from lib.L2_data.repositories.integrations import ImportRedmineRepo
from lib.L2_data.schema.goals.goal_import import GoalImportRemoteSchemaGet

from ..auth import db_organization
from .remote_trackers import remote_trackers_uc

router = APIRouter(prefix="/goals", tags=["integrations - goals"])


def _import_uc(
    tracker_id: int,
    tracker_uc: BaseDBUC = Depends(remote_trackers_uc),
    db: Session = Depends(db_organization),
) -> ImportUC:

    # TODO: спрятать под капот определение трекера и юзкейса
    repo: AbstractImportRepo | None = None
    tracker: RemoteTracker = tracker_uc.get_one(id=tracker_id)

    if tracker and tracker.type.title == "Redmine":
        repo = ImportRedmineRepo(tracker)

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


@router.get("/", response_model=list[GoalImportRemoteSchemaGet])
def get_goals(
    uc: ImportUC = Depends(_import_uc),
) -> list[GoalImport]:
    return uc.get_goals()


@router.post("/import", response_model=Msg)
def import_goals(
    goals_ids: list[str],
    uc: ImportUC = Depends(_import_uc),
) -> Msg:
    return uc.import_goals(goals_ids)


# @router.post("/tasks", response_model=Msg)
# def tasks(uc: ImportUC = Depends(_import_uc)) -> Msg:
#     return uc.import_tasks()
