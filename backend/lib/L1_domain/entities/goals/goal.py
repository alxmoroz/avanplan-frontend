#  Copyright (c) 2022. Alexandr Moroz
from __future__ import annotations

from dataclasses import dataclass

from .goal_report import GoalReport
from .goal_status import GoalStatus
from .smartable import Smartable
from .task import Task


@dataclass
class Goal(Smartable):

    report: GoalReport | None = None
    goals: list[Goal] | None = None
    tasks: list[Task] | None = None
    status: GoalStatus | None = None
