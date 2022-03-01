#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, Integer

from .base import BaseModel, TitledUnique


class TaskPriority(TitledUnique, BaseModel):
    order = Column(Integer)
