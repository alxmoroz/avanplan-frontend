#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder

from lib.L1_domain.entities import TaskPriority
from lib.L2_data.models import TaskPriority as TPModel
from lib.L2_data.schema import TaskPrioritySchemaGet, TaskPrioritySchemaUpsert

from ..auth import WorkspaceMapper
from ..base_mapper import BaseMapper


class TaskPriorityMapper(BaseMapper[TaskPrioritySchemaGet, TaskPrioritySchemaUpsert, TaskPriority, TPModel]):
    def __init__(self):
        super().__init__(schema_get_cls=TaskPrioritySchemaGet, schema_upd_cls=TaskPrioritySchemaUpsert, entity_cls=TaskPriority)

    def entity_from_schema_get(self, s: TaskPrioritySchemaGet) -> TaskPriority | None:
        if s:
            t: TaskPriority = super().entity_from_schema_get(s)
            t.workspace = WorkspaceMapper().entity_from_schema_get(s.workspace)
            return t

    def schema_upd_from_entity(self, e: TaskPriority) -> TaskPrioritySchemaUpsert:
        data = jsonable_encoder(e)
        s = TaskPrioritySchemaUpsert(
            **data,
            workspace_id=e.workspace.id if e.workspace else None,
        )
        return s
