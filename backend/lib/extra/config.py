#  Copyright (c) 2022. Alexandr Moroz

from typing import Union

from pydantic import AnyHttpUrl, BaseSettings, EmailStr, PostgresDsn, validator


class Settings(BaseSettings):
    API_PATH: str = "/api/v1"
    SECRET_KEY: str = "b202faeae347ac1f2ea1511a7bc9c49ad07c8e8c97fc8972cb45bda6beb11370"
    # SERVER_NAME: str
    # SERVER_HOST: AnyHttpUrl
    # BACKEND_CORS_ORIGINS is a JSON-formatted list of origins
    # e.g: '["http://localhost", "http://localhost:4200", "http://localhost:3000", \
    # "http://localhost:8080", "http://local.dockertoolbox.tiangolo.com"]'
    BACKEND_CORS_ORIGINS: list[AnyHttpUrl] = []

    @validator("BACKEND_CORS_ORIGINS", pre=True)
    def assemble_cors_origins(cls, v: Union[str, list[str]]) -> Union[list[str], str]:
        if isinstance(v, str) and not v.startswith("["):
            return [i.strip() for i in v.split(",")]
        elif isinstance(v, (list, str)):
            return v
        raise ValueError(v)

    PROJECT_NAME: str = "Hercules"
    POSTGRES_SERVER: str = "localhost"
    POSTGRES_USER: str = "hercules"
    POSTGRES_PASSWORD: str = "hercules"
    POSTGRES_DB: str = "hercules"
    SQLALCHEMY_DATABASE_URI: PostgresDsn | None

    @validator("SQLALCHEMY_DATABASE_URI", pre=True)
    def assemble_db_connection(cls, v: str | None, values: dict[str, any]) -> any:
        if isinstance(v, str):
            return v
        return PostgresDsn.build(
            scheme="postgresql",
            user=values.get("POSTGRES_USER"),
            password=values.get("POSTGRES_PASSWORD"),
            host=values.get("POSTGRES_SERVER"),
            path=f"/{values.get('POSTGRES_DB') or ''}",
        )

    FIRST_SUPERUSER_EMAIL: EmailStr = "admin@test.com"
    FIRST_SUPERUSER_PASSWORD: str = "admin"
    USERS_OPEN_REGISTRATION: bool = False
    TEST_USER_EMAIL = "test@test.com"

    class Config:
        case_sensitive = True


settings = Settings()
