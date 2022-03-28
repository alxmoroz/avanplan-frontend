#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities import Goal
from lib.L2_data.models import Goal as GoalModel
from lib.L2_data.schema import GoalSchemaGet, GoalSchemaUpsert

from ..entity_repo import EntityRepo
from .goal_status_repo import GoalStatusRepo
from .task_repo import TaskRepo


class GoalRepo(EntityRepo[GoalSchemaGet, GoalSchemaUpsert, Goal, GoalModel]):
    def __init__(self):
        super().__init__(
            schema_get_cls=GoalSchemaGet,
            schema_upd_cls=GoalSchemaUpsert,
            entity_cls=Goal,
        )

    def entity_from_schema_get(self, s: GoalSchemaGet) -> Goal | None:
        if s:
            g: Goal = super().entity_from_schema_get(s)
            g.status = GoalStatusRepo().entity_from_schema_get(s.status)
            g.tasks = [TaskRepo().entity_from_schema_get(t) for t in s.tasks]
            return g
