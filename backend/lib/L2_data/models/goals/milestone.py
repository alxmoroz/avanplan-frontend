#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer
from sqlalchemy.orm import relationship

from .base import SmartModel


class Milestone(SmartModel):

    goal_id = Column(Integer, ForeignKey("goals.id", ondelete="CASCADE"), nullable=False)
    goal = relationship("Goal")

    status_id = Column(Integer, ForeignKey("milestonestatuss.id"))
    status = relationship("MilestoneStatus")
