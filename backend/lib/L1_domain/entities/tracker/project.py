#  Copyright (c) 2022. Alexandr Moroz
from .base_tracker import BaseTrackerEntity, Importable
from .task import Task


class Project(BaseTrackerEntity, Importable):

    # projects: list[Project] = []
    tasks: list[Task] = []
    # versions: list[Version] = []
