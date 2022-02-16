#  Copyright (c) 2022. Alexandr Moroz

from fastapi import FastAPI, HTTPException
from fastapi.exception_handlers import http_exception_handler

from lib.L1_domain.entities.api.exceptions import ApiException
from lib.L2_data.settings import settings
from lib.L3_app.api.routers import api_router

app = FastAPI(title=settings.PROJECT_NAME, openapi_url=f"{settings.API_PATH}/openapi.json")
app.include_router(api_router, prefix=settings.API_PATH)


@app.exception_handler(ApiException)
async def api_exception_handler(request, exc: ApiException):
    return await http_exception_handler(request, HTTPException(exc.code, exc.detail))
