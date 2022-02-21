#  Copyright (c) 2022. Alexandr Moroz


from .base_tracker import BaseTrackerEntity, Importable, TimeBound


class TaskStatus(BaseTrackerEntity):
    pass


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
