#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities import Goal
from lib.L2_data.schema import GoalSchemaCreate, GoalSchemaGet

from ..entity_repo import EntityRepo
from .goal_report import GoalReportRepo
from .goal_status_repo import GoalStatusRepo


class GoalRepo(EntityRepo):
    def __init__(self):
        super().__init__(
            schema_get_cls=GoalSchemaGet,
            schema_create_cls=GoalSchemaCreate,
            entity_cls=Goal,
        )

    def entity_from_schema(self, s: GoalSchemaGet) -> Goal | None:
        if s:
            g: Goal = super().entity_from_schema(s)
            g.status = GoalStatusRepo().entity_from_schema(s.status)
            g.report = GoalReportRepo().entity_from_schema(s.report)
            return g
