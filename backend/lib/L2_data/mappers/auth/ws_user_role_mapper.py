#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import WSUserRole
from lib.L2_data.models.auth import WSUserRole as WSUserRoleModel
from lib.L2_data.schema import WSUserRoleSchemaGet, WSUserRoleSchemaUpsert

from ..base_mapper import BaseMapper
from .workspace_mapper import WorkspaceMapper


class WSUserRoleMapper(BaseMapper[WSUserRoleSchemaGet, WSUserRoleSchemaUpsert, WSUserRole, WSUserRoleModel]):
    def __init__(self):
        super().__init__(schema_get_cls=WSUserRoleSchemaGet, schema_upd_cls=WSUserRoleSchemaUpsert, entity_cls=WSUserRole)

    def entity_from_schema_get(self, s: WSUserRoleSchemaGet) -> WSUserRole | None:
        if s:
            r: WSUserRole = super().entity_from_schema_get(s)
            r.workspace = WorkspaceMapper().entity_from_schema_get(s.workspace)
            return r
