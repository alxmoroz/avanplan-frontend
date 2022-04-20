#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, ForeignKey, Integer
from sqlalchemy.orm import relationship

from ..base_model import BaseModel
from .smartable import Smartable


class Task(Smartable, BaseModel):
    parent_id = Column(Integer, ForeignKey("tasks.id", ondelete="CASCADE"))

    # parent = relationship("Task", remote_side="Task.id")
    tasks = relationship("Task", remote_side="Task.parent_id")

    goal_id = Column(Integer, ForeignKey("goals.id", ondelete="CASCADE"), nullable=False)
    goal = relationship("Goal", back_populates="tasks")

    status_id = Column(Integer, ForeignKey("taskstatuss.id"))
    status = relationship("TaskStatus")

    priority_id = Column(Integer, ForeignKey("taskprioritys.id"))
    priority = relationship("TaskPriority")
