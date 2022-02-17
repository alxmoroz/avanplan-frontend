#  Copyright (c) 2022. Alexandr Moroz

from pydantic import EmailStr

from ..base_entity import IdentifiableEntity


class User(IdentifiableEntity):
    email: EmailStr
    password: str
    full_name: str | None
    is_active: bool = True
    is_superuser: bool = False

    class Config:
        orm_mode = True
