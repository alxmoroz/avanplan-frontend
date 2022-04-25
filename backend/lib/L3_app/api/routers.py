#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter

from .v1 import auth, goals, tasks
from .v1.integrations.routers import integrations_router

api_router = APIRouter()

api_router.include_router(goals.router, tags=["goals"])
api_router.include_router(tasks.router, tags=["tasks"])
api_router.include_router(integrations_router)
api_router.include_router(auth.router, tags=["auth"])
