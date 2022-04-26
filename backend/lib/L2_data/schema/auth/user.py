#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC

from pydantic import EmailStr

from ..base_schema import BaseSchema, PKGetable, PKUpsertable


class _UserSchema(BaseSchema, ABC):
    email: EmailStr
    password: str
    full_name: str | None = None


class UserSchemaGet(_UserSchema, PKGetable):
    pass


class UserSchemaUpsert(_UserSchema, PKUpsertable):
    pass
