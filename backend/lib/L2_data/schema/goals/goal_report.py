#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from lib.L1_domain.entities import GoalReport

from ..base_schema import BaseGetSchema


class GoalReportSchema(BaseGetSchema):
    tasks_count: int | None
    closed_tasks_count: int | None
    eta_date: datetime | None
    fact_speed: float | None
    plan_speed: float | None

    def entity(self):
        return GoalReport(**self.dict())
