#  Copyright (c) 2022. Alexandr Moroz

from ..auth import WorkspaceSchemaGet
from ..base_schema import BaseSchema, Orderable, PKGetable, PKUpsertable, Titleable


class _TaskPrioritySchema(Titleable, Orderable, BaseSchema):
    pass


class TaskPrioritySchemaGet(_TaskPrioritySchema, PKGetable):
    workspace: WorkspaceSchemaGet


class TaskPrioritySchemaUpsert(_TaskPrioritySchema, PKUpsertable):
    workspace_id: int
