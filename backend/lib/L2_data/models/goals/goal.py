#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer
from sqlalchemy.orm import relationship

from ..base_model import BaseModel
from .base import ImportableFields, StatusFields, TitledFields


class GoalStatus(StatusFields, TitledFields, BaseModel):
    pass


class Goal(TitledFields, ImportableFields, BaseModel):
    parent_id = Column(Integer, ForeignKey("goals.id", ondelete="CASCADE"))
    goals = relationship("Goal", cascade="all, delete")

    status_id = Column(Integer, ForeignKey("goalstatuss.id"))

    tasks = relationship("Task", back_populates="goal", cascade="all, delete")
    milestones = relationship("Milestone", back_populates="goal", cascade="all, delete")
