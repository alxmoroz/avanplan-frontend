#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import Organization
from lib.L2_data.models_auth import Organization as OrganizationModel
from lib.L2_data.schema import OrganizationSchemaGet, OrganizationSchemaUpsert

from ..base_mapper import BaseMapper


class OrganizationMapper(BaseMapper[OrganizationSchemaGet, OrganizationSchemaUpsert, Organization, OrganizationModel]):
    def __init__(self):
        super().__init__(schema_get_cls=OrganizationSchemaGet, schema_upd_cls=OrganizationSchemaUpsert, entity_cls=Organization)
