#  Copyright (c) 2022. Alexandr Moroz

from pydantic import EmailStr

from ..base_schema import BaseSchema, PKGetable, PKUpsertable
from .organization import OrganizationSchemaGet


class _UserSchema(BaseSchema):
    email: EmailStr
    password: str
    full_name: str | None = None
    is_active: bool = True
    is_superuser: bool = False


class UserSchemaGet(_UserSchema, PKGetable):
    organization: OrganizationSchemaGet


class UserSchemaUpsert(_UserSchema, PKUpsertable):
    organization_id: int
