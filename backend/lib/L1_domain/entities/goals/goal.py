#  Copyright (c) 2022. Alexandr Moroz
from __future__ import annotations

from .base import BaseGoal, Statusable, Titled


class GoalStatus(Titled, Statusable):
    pass


class Goal(BaseGoal):

    parent: Goal | None
    # goals: list[Goal] | None
    # tasks: list[Task] | None
    status: GoalStatus | None
    # milestones: list[Milestone] | None
