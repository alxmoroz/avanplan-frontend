#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter

from .import_goals import router as goals_router
from .remote_trackers import router as remote_tracker_router

integrations_router = APIRouter(prefix="/integrations")
integrations_router.include_router(goals_router)
integrations_router.include_router(remote_tracker_router)
