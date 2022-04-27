#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import Workspace
from lib.L2_data.models.auth import Workspace as WSModel
from lib.L2_data.schema import WorkspaceSchemaGet, WorkspaceSchemaUpsert

from ..base_mapper import BaseMapper


class WorkspaceMapper(BaseMapper[WorkspaceSchemaGet, WorkspaceSchemaUpsert, Workspace, WSModel]):
    def __init__(self):
        super().__init__(schema_get_cls=WorkspaceSchemaGet, schema_upd_cls=WorkspaceSchemaUpsert, entity_cls=Workspace)
