#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from dataclasses import dataclass

from .goal_import import GoalImport
from .task import Task

# TODO: может, лучше со схемами работать? Тогда ещё подумать как их протаскивать в юзкейс Л1


@dataclass
class TaskImport(Task):
    goal: GoalImport | None = None
    parent: TaskImport | None = None
