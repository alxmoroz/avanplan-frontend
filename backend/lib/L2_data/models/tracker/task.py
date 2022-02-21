#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship

from ..base_model import BaseModel
from .base import BaseTrackerFields, ImportableFields, TimeBoundFields


class TaskStatus(BaseTrackerFields, BaseModel):
    title = Column(String, unique=True)


class Task(BaseTrackerFields, ImportableFields, TimeBoundFields, BaseModel):
    status_id = Column(Integer, ForeignKey("taskstatuss.id"))
    # status = relationship("TaskStatus", back_populates="tasks")
    status = relationship("TaskStatus")

    project_id = Column(Integer, ForeignKey("projects.id", ondelete="CASCADE"))
    project = relationship("Project", back_populates="tasks")

    # TODO: определить модели и связи
    # priority: TaskPriority
    # version: Version | None
    # assigned_to: Person | None
    # author: Person | None
