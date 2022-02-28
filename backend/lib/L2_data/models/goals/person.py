#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, String

from ..base_model import BaseModel
from .base import ImportableFields


class Person(ImportableFields, BaseModel):
    firstname = Column(String)
    lastname = Column(String)
