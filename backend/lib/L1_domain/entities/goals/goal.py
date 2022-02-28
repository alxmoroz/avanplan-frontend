#  Copyright (c) 2022. Alexandr Moroz
from __future__ import annotations

from ..base_entity import DBPersistent
from .base import BaseSmartPersistent, Statusable, Titled


class GoalStatus(Titled, Statusable, DBPersistent):
    pass


class Goal(BaseSmartPersistent):

    parent: Goal | None
    # goals: list[Goal] | None
    # tasks: list[Task] | None
    status: GoalStatus | None
    # milestones: list[Milestone] | None
