#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, ForeignKey, Integer, String

from ..base_model import BaseModel
from .base import ImportableFields, StatusFields, TimeBoundFields, TrackerFields


class TaskStatus(TrackerFields, StatusFields, BaseModel):
    pass


class TaskPriority(TrackerFields, BaseModel):
    title = Column(String, unique=True)
    order = Column(Integer)


class Task(TrackerFields, ImportableFields, TimeBoundFields, BaseModel):
    parent_id = Column(Integer, ForeignKey("tasks.id", ondelete="CASCADE"))

    project_id = Column(Integer, ForeignKey("projects.id", ondelete="CASCADE"), nullable=False)
    # project = relationship("Project", back_populates="tasks")

    milestone_id = Column(Integer, ForeignKey("milestones.id"))

    status_id = Column(Integer, ForeignKey("taskstatuss.id"))
    # status = relationship("TaskStatus")

    priority_id = Column(Integer, ForeignKey("taskprioritys.id"))
    # priority = relationship("TaskPriority")

    assigned_person_id = Column(Integer, ForeignKey("persons.id"))
    # assigned_person = relationship("Person")

    author_id = Column(Integer, ForeignKey("persons.id"))
    # author = relationship("Person")
