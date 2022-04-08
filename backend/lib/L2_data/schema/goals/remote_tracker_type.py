#  Copyright (c) 2022. Alexandr Moroz


from ..base_schema import BaseSchema, PKGetable, PKUpsertable, Titleable


class _RemoteTrackerTypeSchema(Titleable, BaseSchema):
    pass


class RemoteTrackerTypeSchemaGet(_RemoteTrackerTypeSchema, PKGetable):
    pass


class RemoteTrackerTypeSchemaUpsert(_RemoteTrackerTypeSchema, PKUpsertable):
    pass
