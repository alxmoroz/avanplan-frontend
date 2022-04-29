#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from typing import Optional

from pydantic import HttpUrl

from ..base_schema import PKGetable, PKUpsertable, WorkspaceBounded
from .remote_tracker_type import RemoteTrackerTypeSchemaGet


class _RemoteTrackerSchema(WorkspaceBounded, ABC):
    url: HttpUrl
    login_key: str
    password: Optional[str]
    description: Optional[str]


class RemoteTrackerSchemaGet(_RemoteTrackerSchema, PKGetable):
    type: RemoteTrackerTypeSchemaGet


class RemoteTrackerSchemaUpsert(_RemoteTrackerSchema, PKUpsertable):
    remote_tracker_type_id: Optional[int]
