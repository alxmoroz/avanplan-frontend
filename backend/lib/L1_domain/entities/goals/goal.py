#  Copyright (c) 2022. Alexandr Moroz
from __future__ import annotations

from typing import Optional

from .base import SmartPersistent
from .goal_status import GoalStatus


class Goal(SmartPersistent):

    parent: Optional[Goal]
    # goals: Optional[list[Goal]]
    # tasks: Optional[list[Task]]
    status: Optional[GoalStatus]
    # milestones: Optional[list[Milestone]]
    plan_speed: Optional[float]
    fact_speed: Optional[float]
