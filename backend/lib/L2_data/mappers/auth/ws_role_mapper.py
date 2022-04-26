#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import WSRole
from lib.L2_data.models.auth import WSRole as WSRoleModel
from lib.L2_data.schema import WSRoleSchemaGet, WSRoleSchemaUpsert

from ..base_mapper import BaseMapper


class WSRoleMapper(BaseMapper[WSRoleSchemaGet, WSRoleSchemaUpsert, WSRole, WSRoleModel]):
    def __init__(self):
        super().__init__(schema_get_cls=WSRoleSchemaGet, schema_upd_cls=WSRoleSchemaUpsert, entity_cls=WSRole)
