#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from typing import Optional

from pydantic import EmailStr, validator

from ..base_schema import BaseSchema, PKGetable, PKUpsertable


class _BasePersonSchema(BaseSchema, ABC):
    email: EmailStr
    firstname: Optional[str]
    lastname: Optional[str]


class PersonSchemaGet(_BasePersonSchema, PKGetable):
    pass


class PersonSchemaUpsert(_BasePersonSchema, PKUpsertable):
    @validator("firstname", "lastname", always=True)
    def name_must_filled(cls, v, values):
        vals = [values.get(attr, None) for attr in ["firstname", "lastname"]]
        vals.append(v)
        filled = [bool(val and not val.isspace()) for val in vals]

        if sum(filled) == 0:
            raise ValueError("firstname or lastname must be filled")

        return v
