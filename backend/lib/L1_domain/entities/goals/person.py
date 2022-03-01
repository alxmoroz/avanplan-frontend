#  Copyright (c) 2022. Alexandr Moroz
from typing import Optional

from pydantic import validator

from ..base_entity import DBPersistent
from .base import Importable


class Person(Importable, DBPersistent):
    firstname: Optional[str]
    lastname: Optional[str]

    @validator("firstname", "lastname", always=True)
    def name_must_filled(cls, v, values):

        vals = [values.get(attr, None) for attr in ["firstname", "lastname"]]
        vals.append(v)
        filled = [bool(val and not val.isspace()) for val in vals]

        if sum(filled) == 0:
            raise ValueError("firstname or lastname must be filled")

        return v
