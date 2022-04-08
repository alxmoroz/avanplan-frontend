#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder

from lib.L1_domain.entities import TaskImport
from lib.L2_data.models import Task as TaskModel
from lib.L2_data.schema import TaskImportSchemaGet, TaskImportSchemaUpsert

from ..base_mapper import BaseMapper
from ..goals import GoalImportMapper


class TaskImportMapper(BaseMapper[TaskImportSchemaGet, TaskImportSchemaUpsert, TaskImport, TaskModel]):
    def __init__(self):
        super().__init__(
            schema_get_cls=TaskImportSchemaGet,
            schema_upd_cls=TaskImportSchemaUpsert,
            entity_cls=TaskImport,
        )

    def entity_from_schema_get(self, s: TaskImportSchemaGet) -> TaskImport | None:
        if s:
            t: TaskImport = super().entity_from_schema_get(s)
            t.goal = GoalImportMapper().entity_from_schema_get(s.goal)
            t.parent = self.entity_from_schema_get(s.parent)
            return t

    def schema_upd_from_entity(self, e: TaskImport) -> TaskImportSchemaUpsert:

        data = jsonable_encoder(e)
        data.pop("parent_id")

        s = TaskImportSchemaUpsert(
            **data,
            goal_id=e.goal.id,
            parent_id=e.parent.id if e.parent else None,
            status_id=e.status.id if e.status else None,
            priority_id=e.priority.id if e.priority else None,
            assignee_id=e.assignee.id if e.assignee else None,
            author_id=e.author.id if e.author else None,
            # remote_tracker_id=e.remote_tracker.id if e.remote_tracker else None,
        )

        return s
