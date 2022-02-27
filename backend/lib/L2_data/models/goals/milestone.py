#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer
from sqlalchemy.orm import relationship

from ..base_model import BaseModel
from .base import ImportableFields, StatusFields, TimeBoundFields, TitledFields


class MilestoneStatus(StatusFields, TitledFields, BaseModel):
    pass


class Milestone(TitledFields, ImportableFields, TimeBoundFields, BaseModel):

    goal_id = Column(Integer, ForeignKey("goals.id", ondelete="CASCADE"), nullable=False)
    goal = relationship("Goal", back_populates="milestones")

    status_id = Column(Integer, ForeignKey("milestonestatuss.id"))
    status = relationship("MilestoneStatus")

    tasks = relationship("Task", back_populates="milestone")
