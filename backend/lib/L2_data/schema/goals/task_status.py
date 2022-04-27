#  Copyright (c) 2022. Alexandr Moroz

from ..auth import WorkspaceSchemaGet
from ..base_schema import BaseSchema, PKGetable, PKUpsertable, Statusable, Titleable


class _TaskStatusSchema(Titleable, Statusable, BaseSchema):
    pass


class TaskStatusSchemaGet(PKGetable, _TaskStatusSchema):
    workspace: WorkspaceSchemaGet


class TaskStatusSchemaUpsert(_TaskStatusSchema, PKUpsertable):
    workspace_id: int
