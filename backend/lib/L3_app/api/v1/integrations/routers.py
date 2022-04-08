#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter

from .import_redmine import router as redmine_router
from .remote_trackers import router as remote_tracker_router

integrations_router = APIRouter(prefix="/integrations")
integrations_router.include_router(redmine_router)
integrations_router.include_router(remote_tracker_router)
