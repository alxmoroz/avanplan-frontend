#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter

from .endpoints import auth, import_redmine, users

api_router = APIRouter()
api_router.include_router(auth.router, prefix="/auth", tags=["auth"])
api_router.include_router(users.router, prefix="/users", tags=["users"])
api_router.include_router(
    import_redmine.router, prefix="/import/redmine", tags=["import - redmine"]
)
