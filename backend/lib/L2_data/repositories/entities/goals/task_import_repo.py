#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder

from lib.L1_domain.entities import TaskImport
from lib.L2_data.schema import TaskImportSchemaGet, TaskSchemaCreate

from ..entity_repo import EntityRepo
from ..goals import GoalImportRepo


class TaskImportRepo(EntityRepo):
    def __init__(self):
        super().__init__(
            schema_get_cls=TaskImportSchemaGet,
            schema_create_cls=TaskSchemaCreate,
            entity_cls=TaskImport,
        )

    def entity_from_schema(self, s: TaskImportSchemaGet) -> TaskImport | None:
        if s:
            t: TaskImport = super().entity_from_schema(s)
            t.goal = GoalImportRepo().entity_from_schema(s.goal)
            t.parent = self.entity_from_schema(s.parent)
            return t

    def schema_from_entity(self, e: TaskImport) -> TaskSchemaCreate:

        s = TaskSchemaCreate(
            goal_id=e.goal.id,
            parent_id=e.parent.id if e.parent else None,
            status_id=e.status.id if e.status else None,
            priority_id=e.priority.id if e.priority else None,
            assignee_id=e.assignee.id if e.assignee else None,
            author_id=e.author.id if e.author else None,
            **jsonable_encoder(e),
        )

        return s
