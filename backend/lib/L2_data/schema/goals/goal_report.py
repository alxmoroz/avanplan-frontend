#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from ..base_schema import BaseSchema


class GoalReportSchema(BaseSchema):
    eta_date: datetime | None
    fact_speed: float | None
    plan_speed: float | None
