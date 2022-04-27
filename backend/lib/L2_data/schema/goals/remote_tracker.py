#  Copyright (c) 2022. Alexandr Moroz
from typing import Optional

from pydantic import HttpUrl

from .. import WorkspaceSchemaGet
from ..base_schema import BaseSchema, PKGetable, PKUpsertable
from .remote_tracker_type import RemoteTrackerTypeSchemaGet


class _RemoteTrackerSchema(BaseSchema):
    url: HttpUrl
    login_key: str
    password: Optional[str]
    description: Optional[str]


class RemoteTrackerSchemaGet(_RemoteTrackerSchema, PKGetable):
    type: RemoteTrackerTypeSchemaGet
    workspace: WorkspaceSchemaGet


class RemoteTrackerSchemaUpsert(_RemoteTrackerSchema, PKUpsertable):
    remote_tracker_type_id: Optional[int]
    workspace_id: int
