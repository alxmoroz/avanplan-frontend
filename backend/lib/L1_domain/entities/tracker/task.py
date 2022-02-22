#  Copyright (c) 2022. Alexandr Moroz

from .base_tracker import BaseTrackerEntity, Importable, TimeBound


class TaskStatus(BaseTrackerEntity):
    closed: bool | None

    def __init__(self, closed=False, *args, **kwargs):
        super().__init__(closed=closed, *args, **kwargs)

    # @validator("closed")
    # def set_closed(cls, closed):
    #     return closed or False
    #
    # class Config:
    #     validate_assignment = True


class TaskPriority(BaseTrackerEntity):
    order: int


class Task(BaseTrackerEntity, Importable, TimeBound):

    status_id: int | None
    status: TaskStatus | None

    # priority: TaskPriority
    # version: Version | None
    # tasks: list[Task] | None
    # assigned_to: Person | None
    # author: Person | None
    project_id: int | None
