#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer
from sqlalchemy.orm import relationship

from ..base_model import BaseModel
from .smartable import Smartable


class Goal(Smartable, BaseModel):
    parent_id = Column(Integer, ForeignKey("goals.id", ondelete="CASCADE"))

    status_id = Column(Integer, ForeignKey("goalstatuss.id"))
    status = relationship("GoalStatus")

    # goals = relationship("Goal", cascade="all, delete", remote_side="Goal.parent_id")
    tasks = relationship("Task", cascade="all, delete")
