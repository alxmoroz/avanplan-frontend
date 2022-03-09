#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime


@dataclass
class GoalReport:
    tasks_count: int | None
    closed_tasks_count: int | None
    eta_date: datetime | None
    fact_speed: float | None
    plan_speed: float | None
