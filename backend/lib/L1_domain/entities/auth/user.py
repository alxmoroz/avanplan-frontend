#  Copyright (c) 2022. Alexandr Moroz

from pydantic import EmailStr

from ..base_entity import BaseEntity


class BaseUserEntity(BaseEntity):
    email: EmailStr | None
    is_active: bool = True
    is_superuser: bool = False
    full_name: str | None


class CreateUser(BaseUserEntity):
    email: EmailStr
    password: str


class UpdateUser(BaseUserEntity):
    password: str | None


class User(BaseUserEntity):
    id: int | None

    class Config:
        orm_mode = True
