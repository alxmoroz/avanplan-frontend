#  Copyright (c) 2022. Alexandr Moroz

from pydantic import EmailStr

from ..base_entity import DBPersistent


class User(DBPersistent):
    email: EmailStr
    password: str
    full_name: str | None
    is_active: bool = True
    is_superuser: bool = False
