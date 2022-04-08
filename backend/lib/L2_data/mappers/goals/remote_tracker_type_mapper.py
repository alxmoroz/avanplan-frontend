#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities.goals import RemoteTrackerType

from ...models import RemoteTrackerType as RemoteTrackerTypeModel
from ...schema.goals.remote_tracker_type import RemoteTrackerTypeSchemaGet, RemoteTrackerTypeSchemaUpsert
from ..base_mapper import BaseMapper


class RemoteTrackerTypeMapper(BaseMapper[RemoteTrackerTypeSchemaGet, RemoteTrackerTypeSchemaUpsert, RemoteTrackerType, RemoteTrackerTypeModel]):
    def __init__(self):
        super().__init__(schema_get_cls=RemoteTrackerTypeSchemaGet, schema_upd_cls=RemoteTrackerTypeSchemaUpsert, entity_cls=RemoteTrackerType)
