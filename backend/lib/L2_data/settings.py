#  Copyright (c) 2022. Alexandr Moroz


class Settings:
    API_PATH: str = "/v1"
    SECRET_KEY: str = "b202faeae347ac1f2ea1511a7bc9c49ad07c8e8c97fc8972cb45bda6beb11370"
    # 60 minutes * 24 hours * 7 days = 7 days
    AUTH_TOKEN_EXPIRATION_MINUTES: int = 60 * 24 * 7

    DEFAULT_ADMIN_PASSWORD = "admin"


settings = Settings()
