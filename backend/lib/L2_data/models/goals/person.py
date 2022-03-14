#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, String

from ..base_model import BaseModel, Emailable


class Person(Emailable, BaseModel):
    firstname = Column(String)
    lastname = Column(String)
