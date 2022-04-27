#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from typing import Optional

from pydantic import EmailStr, root_validator

from .. import WorkspaceSchemaGet
from ..base_schema import BaseSchema, PKGetable, PKUpsertable


class _PersonSchema(BaseSchema, ABC):
    email: EmailStr
    firstname: Optional[str]
    lastname: Optional[str]


class PersonSchemaGet(_PersonSchema, PKGetable):
    workspace: WorkspaceSchemaGet


class PersonSchemaUpsert(_PersonSchema, PKUpsertable):
    workspace_id: int

    @root_validator
    def name_must_filled(cls, values):
        vals = [values.get(attr, None) for attr in ["firstname", "lastname"]]
        filled = [bool(val and not val.isspace()) for val in vals]

        if sum(filled) == 0:
            raise ValueError("firstname or lastname must be filled")

        return values
