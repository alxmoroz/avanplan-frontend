#  Copyright (c) 2022. Alexandr Moroz

from .base_tracker import ImportableEntity


class Person(ImportableEntity):
    firstname: str = ""
    lastname: str = ""

    class Config:
        orm_mode = True
