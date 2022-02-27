#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import Column, String

# from .. import Task
from ..base_model import BaseModel
from .base import ImportableFields

# from L1_domain.entities.goals import BaseTask, OtherTask


class Person(ImportableFields, BaseModel):
    firstname = Column(String)
    lastname = Column(String)

    # authored_tasks = relationship("Task", back_populates="author", foreign_keys=[Task.id], remote_side="Task.author_id")
    # assigned_tasks = relationship("Task", back_populates="assignee", foreign_keys=[Task.id], remote_side="Task.assignee_id")
