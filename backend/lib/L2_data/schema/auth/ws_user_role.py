#  Copyright (c) 2022. Alexandr Moroz
from abc import ABC

from ..base_schema import BaseSchema, PKGetable, PKUpsertable
from .workspace import WorkspaceSchemaGet


class _WSUserRoleSchema(BaseSchema, ABC):
    user_id: int
    ws_role_id: int


class WSUserRoleSchemaGet(_WSUserRoleSchema, PKGetable):
    workspace: WorkspaceSchemaGet


class WSUserRoleSchemaUpsert(_WSUserRoleSchema, PKUpsertable):
    workspace_id: int
