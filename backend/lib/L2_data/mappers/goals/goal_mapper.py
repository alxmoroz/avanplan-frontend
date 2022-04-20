#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities import Goal
from lib.L2_data.models import Goal as GoalModel
from lib.L2_data.schema import GoalSchemaGet, GoalSchemaUpsert

from ..base_mapper import BaseMapper
from .goal_status_mapper import GoalStatusMapper
from .person_mapper import PersonMapper
from .task_mapper import TaskMapper


class GoalMapper(BaseMapper[GoalSchemaGet, GoalSchemaUpsert, Goal, GoalModel]):
    def __init__(self):
        super().__init__(
            schema_get_cls=GoalSchemaGet,
            schema_upd_cls=GoalSchemaUpsert,
            entity_cls=Goal,
        )

    def entity_from_schema_get(self, s: GoalSchemaGet) -> Goal | None:
        if s:
            g: Goal = super().entity_from_schema_get(s)
            g.status = GoalStatusMapper().entity_from_schema_get(s.status)
            g.tasks = [TaskMapper().entity_from_schema_get(t) for t in s.tasks]
            g.assignee = PersonMapper().entity_from_schema_get(s.assignee)
            g.author = PersonMapper().entity_from_schema_get(s.author)
            return g
