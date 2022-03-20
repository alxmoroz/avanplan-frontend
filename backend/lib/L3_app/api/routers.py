#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter

from .v1 import auth, goals, import_redmine, tasks, users

api_router = APIRouter()

api_router.include_router(goals.router, tags=["goals"])
api_router.include_router(tasks.router, tags=["tasks"])
api_router.include_router(import_redmine.router, tags=["integrations - redmine"])
api_router.include_router(auth.router, tags=["auth"])
api_router.include_router(users.router, tags=["users"])
