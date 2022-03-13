#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities import GoalReport
from lib.L2_data.schema.goals.goal_report import GoalReportSchema

from ..entity_repo import EntityRepo


class GoalReportRepo(EntityRepo[GoalReportSchema, GoalReportSchema, GoalReport, None]):
    def __init__(self):
        super().__init__(schema_get_cls=GoalReportSchema, schema_upd_cls=GoalReportSchema, entity_cls=GoalReport)
