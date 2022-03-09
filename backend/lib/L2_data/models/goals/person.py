#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, String

from ..base_model import BaseModel, Importable, Timestampable


class Person(Importable, Timestampable, BaseModel):
    firstname = Column(String)
    lastname = Column(String)
