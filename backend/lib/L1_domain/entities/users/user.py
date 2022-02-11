#  Copyright (c) 2022. Alexandr Moroz

from pydantic import EmailStr

from lib.L1_domain.entities.base_entity import BaseEntity


class User(BaseEntity):
    id: int | None
    email: EmailStr
    password: str
    full_name: str | None
    is_active: bool = True
    is_superuser: bool = False

    class Config:
        orm_mode = True
