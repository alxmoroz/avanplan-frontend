#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import relationship

from ..base_model import BaseModel, TitleableUnique


class Workspace(TitleableUnique, BaseModel):
    goals = relationship("Goal", cascade="all, delete")
    task_statuses = relationship("TaskStatus", cascade="all, delete")
    task_priorities = relationship("TaskPriority", cascade="all, delete")
    persons = relationship("Person", cascade="all, delete")
    remote_trackers = relationship("RemoteTracker", cascade="all, delete")
