#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer

from ..base_model import BaseModel
from .base import ImportableFields, StatusFields, TimeBoundFields, TrackerFields


class MilestoneStatus(TrackerFields, StatusFields, BaseModel):
    pass


class Milestone(TrackerFields, ImportableFields, TimeBoundFields, BaseModel):

    goal_id = Column(Integer, ForeignKey("goals.id", ondelete="CASCADE"), nullable=False)

    status_id = Column(Integer, ForeignKey("milestonestatuss.id"))
