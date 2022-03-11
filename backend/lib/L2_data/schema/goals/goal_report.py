#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from ..base_schema import BaseSchema


class GoalReportSchema(BaseSchema):
    tasks_count: int | None
    closed_tasks_count: int | None
    eta_date: datetime | None
    fact_speed: float | None
    plan_speed: float | None
