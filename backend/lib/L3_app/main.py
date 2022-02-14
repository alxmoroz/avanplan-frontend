#  Copyright (c) 2022. Alexandr Moroz

from fastapi import FastAPI

from lib.L2_data.settings import settings
from lib.L3_app.api.routers import api_router

app = FastAPI(title=settings.PROJECT_NAME, openapi_url=f"{settings.API_PATH}/openapi.json")

app.include_router(api_router, prefix=settings.API_PATH)
