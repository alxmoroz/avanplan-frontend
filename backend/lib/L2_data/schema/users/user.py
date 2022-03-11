#  Copyright (c) 2022. Alexandr Moroz

from pydantic import EmailStr

from lib.L1_domain.entities import User
from lib.L2_data.schema.base_schema import BaseGetSchema, Identifiable, Timestampable


class UserSchema(Identifiable, Timestampable, BaseGetSchema):
    email: EmailStr
    password: str
    full_name: str | None = None
    is_active: bool = True
    is_superuser: bool = False

    def entity(self):
        return User(**self.dict())
