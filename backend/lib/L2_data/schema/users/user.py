#  Copyright (c) 2022. Alexandr Moroz
from pydantic import EmailStr

from lib.L2_data.schema.base_schema import Identifiable, Timestampable


class UserSchema(Identifiable, Timestampable):
    email: EmailStr
    password: str
    full_name: str | None = None
    is_active: bool = True
    is_superuser: bool = False
