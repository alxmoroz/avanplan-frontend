#  Copyright (c) 2022. Alexandr Moroz
from abc import ABC

from ..base_schema import BaseSchema, PKGetable, PKUpsertable
from .user import UserSchemaGet
from .workspace import WorkspaceSchemaGet
from .ws_role import WSRoleSchemaGet


class _WSUserRoleSchema(BaseSchema, ABC):
    pass


class WSUserRoleSchemaGet(_WSUserRoleSchema, PKGetable):
    workspace: WorkspaceSchemaGet = None
    user: UserSchemaGet = None
    ws_role: WSRoleSchemaGet = None


class WSUserRoleSchemaUpsert(_WSUserRoleSchema, PKUpsertable):
    workspace_id: int
    user_id: int
    ws_role_id: int
