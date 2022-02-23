#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Boolean, Column, ForeignKey, Integer, String

from ..base_model import BaseModel
from .base import BaseTrackerFields, ImportableFields, TimeBoundFields


class TaskStatus(BaseTrackerFields, BaseModel):
    title = Column(String, unique=True)
    closed = Column(Boolean)


class TaskPriority(BaseTrackerFields, BaseModel):
    title = Column(String, unique=True)
    order = Column(Integer)


class Task(BaseTrackerFields, ImportableFields, TimeBoundFields, BaseModel):
    status_id = Column(Integer, ForeignKey("taskstatuss.id"))
    # status = relationship("TaskStatus")

    priority_id = Column(Integer, ForeignKey("taskprioritys.id"))
    # priority = relationship("TaskPriority")

    project_id = Column(Integer, ForeignKey("projects.id", ondelete="CASCADE"))
    # project = relationship("Project", back_populates="tasks")

    # TODO: определить модели и связи
    # version: Version | None
    # assigned_to: Person | None
    # author: Person | None
