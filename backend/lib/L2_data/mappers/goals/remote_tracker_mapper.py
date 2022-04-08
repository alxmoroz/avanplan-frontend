#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities.goals import RemoteTracker

from ...models import RemoteTracker as RemoteTrackerModel
from ...schema.goals.remote_tracker import RemoteTrackerSchemaGet, RemoteTrackerSchemaUpsert
from ..base_mapper import BaseMapper


class RemoteTrackerMapper(BaseMapper[RemoteTrackerSchemaGet, RemoteTrackerSchemaUpsert, RemoteTracker, RemoteTrackerModel]):
    def __init__(self):
        super().__init__(schema_get_cls=RemoteTrackerSchemaGet, schema_upd_cls=RemoteTrackerSchemaUpsert, entity_cls=RemoteTracker)
