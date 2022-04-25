#  Copyright (c) 2022. Alexandr Moroz


from lib.L2_data.schema.base_schema import BaseSchema, PKGetable, PKUpsertable


class _OrganizationSchema(BaseSchema):
    name: str


class OrganizationSchemaGet(_OrganizationSchema, PKGetable):
    pass


class OrganizationSchemaUpsert(_OrganizationSchema, PKUpsertable):
    pass
