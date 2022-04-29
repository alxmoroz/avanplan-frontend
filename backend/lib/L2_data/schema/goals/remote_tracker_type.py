#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC

from ..base_schema import PKGetable, PKUpsertable, Titleable


class _RemoteTrackerTypeSchema(Titleable, ABC):
    pass


class RemoteTrackerTypeSchemaGet(_RemoteTrackerTypeSchema, PKGetable):
    pass


class RemoteTrackerTypeSchemaUpsert(_RemoteTrackerTypeSchema, PKUpsertable):
    pass
