#  Copyright (c) 2022. Alexandr Moroz
from ..base_entity import BaseEntity
from .base_tracker import Importable


class Person(BaseEntity, Importable):
    firstname: str = ""
    lastname: str = ""

    class Config:
        orm_mode = True
