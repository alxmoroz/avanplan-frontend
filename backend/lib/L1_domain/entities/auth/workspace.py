#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..base_entity import Titleable
from ..goals import Goal, Person, RemoteTracker, TaskPriority, TaskStatus


@dataclass
class Workspace(Titleable):
    goals: list[Goal] = None
    task_statuses: list[TaskStatus] = None
    task_priorities: list[TaskPriority] = None
    persons: list[Person] = None
    remote_trackers: list[RemoteTracker] = None
