#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities.goals import RemoteTracker

from ...models import RemoteTracker as RemoteTrackerModel
from ...schema.goals.remote_tracker import RemoteTrackerSchemaGet, RemoteTrackerSchemaUpsert
from ..base_mapper import BaseMapper
from .remote_tracker_type_mapper import RemoteTrackerTypeMapper


class RemoteTrackerMapper(BaseMapper[RemoteTrackerSchemaGet, RemoteTrackerSchemaUpsert, RemoteTracker, RemoteTrackerModel]):
    def __init__(self):
        super().__init__(schema_get_cls=RemoteTrackerSchemaGet, schema_upd_cls=RemoteTrackerSchemaUpsert, entity_cls=RemoteTracker)

    def entity_from_schema_get(self, s: RemoteTrackerSchemaGet) -> RemoteTracker | None:

        if s:
            t: RemoteTracker = super().entity_from_schema_get(s)
            t.type = RemoteTrackerTypeMapper().entity_from_schema_get(s.type)
            return t
