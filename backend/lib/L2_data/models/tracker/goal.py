#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer

from ..base_model import BaseModel
from .base import ImportableFields, StatusFields, TrackerFields


class GoalStatus(TrackerFields, StatusFields, BaseModel):
    pass


class Goal(TrackerFields, ImportableFields, BaseModel):
    # tasks = relationship(
    #     "Task",
    #     # back_populates="goal",
    #     cascade="all, delete",
    # )

    parent_id = Column(Integer, ForeignKey("goals.id", ondelete="CASCADE"))

    status_id = Column(Integer, ForeignKey("goalstatuss.id"))
