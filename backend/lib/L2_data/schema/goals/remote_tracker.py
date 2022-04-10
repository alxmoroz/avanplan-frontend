#  Copyright (c) 2022. Alexandr Moroz
from typing import Optional

from pydantic import HttpUrl

from ..base_schema import BaseSchema, PKGetable, PKUpsertable, Titleable
from .remote_tracker_type import RemoteTrackerTypeSchemaGet


class _RemoteTrackerSchema(Titleable, BaseSchema):
    url: HttpUrl
    login_key: str
    password: str | None = None


class RemoteTrackerSchemaGet(_RemoteTrackerSchema, PKGetable):
    type: RemoteTrackerTypeSchemaGet


class RemoteTrackerSchemaUpsert(_RemoteTrackerSchema, PKUpsertable):
    remote_tracker_type_id: Optional[int]
