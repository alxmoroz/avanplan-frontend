#  Copyright (c) 2022. Alexandr Moroz


from pydantic import BaseSettings, PostgresDsn, validator


class Settings(BaseSettings):
    API_PATH: str = "/api/v1"
    SECRET_KEY: str = "b202faeae347ac1f2ea1511a7bc9c49ad07c8e8c97fc8972cb45bda6beb11370"
    # 60 minutes * 24 hours * 7 days = 7 days
    AUTH_TOKEN_EXPIRATION_MINUTES: int = 60 * 24 * 7

    PROJECT_NAME: str = "Hercules"
    POSTGRES_SERVER: str = "localhost"
    POSTGRES_USER: str = "hercules"
    POSTGRES_PASSWORD: str = "hercules"
    POSTGRES_DB: str = "hercules"
    SQLALCHEMY_DATABASE_URI: PostgresDsn | None

    @validator("SQLALCHEMY_DATABASE_URI", pre=True)
    def assemble_db_connection(cls, v: str | None, values: dict[str, any]):  # noqa
        return PostgresDsn.build(
            scheme="postgresql",
            user=values.get("POSTGRES_USER"),
            password=values.get("POSTGRES_PASSWORD"),
            host=values.get("POSTGRES_SERVER"),
            path=f"/{values.get('POSTGRES_DB') or ''}",
        )

    TEST_ADMIN_EMAIL = "admin@test.com"
    TEST_ADMIN_PASSWORD = "admin"
    TEST_USER_EMAIL = "test@test.com"
    TEST_USER_PASSWORD = "test"

    class Config:
        case_sensitive = True


settings = Settings()
