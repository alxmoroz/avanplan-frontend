#  Copyright (c) 2022. Alexandr Moroz

from pydantic import validator

from ..base_entity import DBPersistent
from .base import Importable


class Person(DBPersistent, Importable):
    firstname: str | None
    lastname: str | None

    @classmethod
    @validator("firstname", "lastname")
    def name_must_filled(cls, v, values):
        is_empty = True
        for v in values:
            is_empty = v is None or v == ""

        if is_empty:
            raise ValueError("firstname or lastname must be filled")
