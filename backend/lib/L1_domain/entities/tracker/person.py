#  Copyright (c) 2022. Alexandr Moroz

from .base_tracker import Importable


class Person(Importable):
    firstname: str = ""
    lastname: str = ""

    class Config:
        orm_mode = True
