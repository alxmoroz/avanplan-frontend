#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, ForeignKey, Integer
from sqlalchemy.orm import relationship

from ..base_model import BaseModel, WorkspaceBound
from .smartable import Smartable


class Goal(Smartable, WorkspaceBound, BaseModel):
    parent_id = Column(Integer, ForeignKey("goals.id", ondelete="CASCADE"))

    # goals = relationship("Goal", cascade="all, delete", remote_side="Goal.parent_id")
    tasks = relationship("Task", cascade="all, delete")
