#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, String

from ..base_model import BaseModel, Emailable, WorkspaceBound


class Person(Emailable, WorkspaceBound, BaseModel):
    firstname = Column(String)
    lastname = Column(String)
