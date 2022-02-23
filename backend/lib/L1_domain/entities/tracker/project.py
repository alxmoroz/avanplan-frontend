#  Copyright (c) 2022. Alexandr Moroz
from .base_tracker import BaseTrackerEntity, Importable
from .task import Task


class Project(BaseTrackerEntity, Importable):
    # projects: list[Project] = []
    _tasks: list[Task] = []

    @property
    def tasks(self) -> list[Task]:
        return self._tasks

    # versions: list[Version] = []
