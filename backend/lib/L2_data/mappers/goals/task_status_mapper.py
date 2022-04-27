#  Copyright (c) 2022. Alexandr Moroz
from fastapi.encoders import jsonable_encoder

from lib.L1_domain.entities.goals import TaskStatus
from lib.L2_data.models import TaskStatus as TaskStatusModel
from lib.L2_data.schema import TaskStatusSchemaGet, TaskStatusSchemaUpsert

from ..auth import WorkspaceMapper
from ..base_mapper import BaseMapper


class TaskStatusMapper(BaseMapper[TaskStatusSchemaGet, TaskStatusSchemaUpsert, TaskStatus, TaskStatusModel]):
    def __init__(self):
        super().__init__(schema_get_cls=TaskStatusSchemaGet, schema_upd_cls=TaskStatusSchemaUpsert, entity_cls=TaskStatus)

    def entity_from_schema_get(self, s: TaskStatusSchemaGet) -> TaskStatus | None:
        if s:
            ts: TaskStatus = super().entity_from_schema_get(s)
            ts.workspace = WorkspaceMapper().entity_from_schema_get(s.workspace)
            return ts

    def schema_upd_from_entity(self, e: TaskStatus) -> TaskStatusSchemaUpsert:
        data = jsonable_encoder(e)
        s = TaskStatusSchemaUpsert(
            **data,
            workspace_id=e.workspace.id if e.workspace else None,
        )
        return s
