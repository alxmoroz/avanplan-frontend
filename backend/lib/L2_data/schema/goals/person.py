#  Copyright (c) 2022. Alexandr Moroz
from pydantic import validator

from ..base_schema import Identifiable, Importable, Timestampable


class PersonSchema(Identifiable, Importable, Timestampable):

    firstname: str | None = None
    lastname: str | None = None

    @validator("firstname", "lastname", always=True)
    def name_must_filled(cls, v, values):

        vals = [values.get(attr, None) for attr in ["firstname", "lastname"]]
        vals.append(v)
        filled = [bool(val and not val.isspace()) for val in vals]

        if sum(filled) == 0:
            raise ValueError("firstname or lastname must be filled")

        return v
