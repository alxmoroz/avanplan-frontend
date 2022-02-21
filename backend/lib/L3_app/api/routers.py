#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter

from .v1 import auth, import_redmine, tracker, users

api_router = APIRouter()
api_router.include_router(auth.router, tags=["auth"])
api_router.include_router(users.router, tags=["users"])
api_router.include_router(tracker.router, tags=["tracker"])
api_router.include_router(import_redmine.router, tags=["import - redmine"])
