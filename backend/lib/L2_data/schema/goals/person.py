#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from typing import Optional

from pydantic import validator

from ..base_schema import BaseSchema, Importable, PKGetable, PKUpsertable, Timestampable


class _BasePersonSchema(BaseSchema, ABC):
    firstname: Optional[str]
    lastname: Optional[str]


class PersonSchemaGet(_BasePersonSchema, PKGetable, Importable, Timestampable):
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
