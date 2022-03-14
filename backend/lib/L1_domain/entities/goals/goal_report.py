#  Copyright (c) 2022. Alexandr Moroz

from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime


@dataclass
class GoalReport:
    eta_date: datetime | None = None
    fact_speed: float | None = 0
    plan_speed: float | None = 0
