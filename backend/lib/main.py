#  Copyright (c) 2022. Alexandr Moroz

from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware

from lib.L2_app.api.v1.routers import api_router
from lib.extra.config import settings

app = FastAPI(
    title=settings.PROJECT_NAME, openapi_url=f"{settings.API_PATH}/openapi.json"
)

# Set all CORS enabled origins
if settings.BACKEND_CORS_ORIGINS:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

app.include_router(api_router, prefix=settings.API_PATH)
