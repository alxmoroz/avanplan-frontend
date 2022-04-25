#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities import RemoteTrackerType
from lib.L1_domain.usecases.base_db_uc import BaseDBUC
from lib.L2_data.mappers import RemoteTrackerTypeMapper
from lib.L2_data.repositories import db as dbr
from lib.L2_data.schema import RemoteTrackerTypeSchemaGet

from ..auth import db_organization

router = APIRouter(prefix="/types")


def _trackers_types_uc(
    db: Session = Depends(db_organization),
) -> BaseDBUC:
    return BaseDBUC(
        db_repo=dbr.RemoteTrackerTypeRepo(db),
        e_repo=RemoteTrackerTypeMapper(),
    )


@router.get("/", response_model=list[RemoteTrackerTypeSchemaGet])
def get_tracker_types(
    uc: BaseDBUC = Depends(_trackers_types_uc),
) -> list[RemoteTrackerType]:
    return uc.get_all()
