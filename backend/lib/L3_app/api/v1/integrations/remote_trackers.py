#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities import RemoteTracker
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L2_data.mappers import RemoteTrackerMapper
from lib.L2_data.repositories import db as dbr
from lib.L2_data.schema import RemoteTrackerSchemaGet, RemoteTrackerSchemaUpsert

from ..auth import db_organization
from .remote_trackers_types import router as tracker_types_router

router = APIRouter(prefix="/trackers", tags=["integrations - trackers"])
router.include_router(tracker_types_router)


def remote_trackers_uc(
    db: Session = Depends(db_organization),
) -> BaseDBUC:
    return BaseDBUC(
        db_repo=dbr.RemoteTrackerRepo(db),
        e_repo=RemoteTrackerMapper(),
    )


@router.get("/", response_model=list[RemoteTrackerSchemaGet])
def get_trackers(
    uc: BaseDBUC = Depends(remote_trackers_uc),
) -> list[RemoteTracker]:
    return uc.get_all()


@router.post("/", response_model=RemoteTrackerSchemaGet, status_code=201)
def upsert_tracker(
    tracker: RemoteTrackerSchemaUpsert,
    uc: BaseDBUC = Depends(remote_trackers_uc),
) -> RemoteTracker:

    return uc.upsert(tracker)


@router.delete("/{tracker_id}")
def delete_tracker(
    tracker_id: int,
    uc: BaseDBUC = Depends(remote_trackers_uc),
) -> int:

    return uc.delete(tracker_id)
