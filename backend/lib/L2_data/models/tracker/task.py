#  Copyright (c) 2022. Alexandr Moroz

from ..base_model import BaseModel
from .base import BaseTrackerFields, ImportableFields, TimeBoundFields


class Task(BaseModel, BaseTrackerFields, ImportableFields, TimeBoundFields):
    pass
    # TODO: определить модели и связи
    # status: TaskStatus
    # priority: TaskPriority
    # version: Version | None
    # tasks: list[Task] | None
    # assigned_to: Person | None
    # author: Person | None
