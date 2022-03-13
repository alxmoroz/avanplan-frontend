#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder

from lib.L1_domain.entities import TaskImport
from lib.L2_data.models import Task as TaskModel
from lib.L2_data.schema import TaskImportSchemaGet, TaskSchemaUpsert

from ..entity_repo import EntityRepo
from ..goals import GoalImportRepo


class TaskImportRepo(EntityRepo[TaskImportSchemaGet, TaskSchemaUpsert, TaskImport, TaskModel]):
    def __init__(self):
        super().__init__(
            schema_get_cls=TaskImportSchemaGet,
            schema_upd_cls=TaskSchemaUpsert,
            entity_cls=TaskImport,
        )

    def entity_from_schema_get(self, s: TaskImportSchemaGet) -> TaskImport | None:
        if s:
            t: TaskImport = super().entity_from_schema_get(s)
            t.goal = GoalImportRepo().entity_from_schema_get(s.goal)
            t.parent = self.entity_from_schema_get(s.parent)
            return t

    def schema_upd_from_entity(self, e: TaskImport) -> TaskSchemaUpsert:

        s = TaskSchemaUpsert(
            goal_id=e.goal.id,
            parent_id=e.parent.id if e.parent else None,
            status_id=e.status.id if e.status else None,
            priority_id=e.priority.id if e.priority else None,
            assignee_id=e.assignee.id if e.assignee else None,
            author_id=e.author.id if e.author else None,
            **jsonable_encoder(e),
        )

        return s
