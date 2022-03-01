#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, String

from ..base_model import BaseModel
from .base import Importable


class Person(Importable, BaseModel):
    firstname = Column(String)
    lastname = Column(String)
