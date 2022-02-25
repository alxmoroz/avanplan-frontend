#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer

from ..base_model import BaseModel
from .base import ImportableFields, StatusFields, TimeBoundFields, TrackerFields


class MilestoneStatus(TrackerFields, StatusFields, BaseModel):
    pass


class Milestone(TrackerFields, ImportableFields, TimeBoundFields, BaseModel):

    project_id = Column(Integer, ForeignKey("projects.id", ondelete="CASCADE"), nullable=False)

    status_id = Column(Integer, ForeignKey("milestonestatuss.id"))
