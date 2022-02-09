#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from .base_tracker import BaseTrackerEntity, ImportableEntity
from .person import Person
from .version import Version


class TaskStatus(BaseTrackerEntity):
    pass


class TaskPriority(BaseTrackerEntity):
    pass


class Task(ImportableEntity):

    status: TaskStatus
    priority: TaskPriority
    version: Version | None
    # tasks: list[Task] | None
    assigned_to: Person | None
    author: Person | None
    start_date: datetime | None
    due_date: datetime | None

    class Config:
        orm_mode = True
