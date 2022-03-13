#  Copyright (c) 2022. Alexandr Moroz

from pydantic import EmailStr

from lib.L2_data.schema.base_schema import BaseSchema, PKGetable, PKUpsertable, Timestampable


class _UserSchema(BaseSchema):
    email: EmailStr
    password: str
    full_name: str | None = None
    is_active: bool = True
    is_superuser: bool = False


class UserSchemaGet(_UserSchema, PKGetable, Timestampable):
    pass


class UserSchemaUpsert(_UserSchema, PKUpsertable):
    pass
