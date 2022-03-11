#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from pydantic import validator

from ..base_schema import BaseSchema, Identifiable, Importable, Timestampable


class _BasePersonSchema(Identifiable, Importable, Timestampable, BaseSchema, ABC):
    firstname: str | None
    lastname: str | None


class PersonSchemaCreate(_BasePersonSchema):
    @validator("firstname", "lastname", always=True)
    def name_must_filled(cls, v, values):

        vals = [values.get(attr, None) for attr in ["firstname", "lastname"]]
        vals.append(v)
        filled = [bool(val and not val.isspace()) for val in vals]

        if sum(filled) == 0:
            raise ValueError("firstname or lastname must be filled")

        return v


class PersonSchemaGet(_BasePersonSchema):
    pass
