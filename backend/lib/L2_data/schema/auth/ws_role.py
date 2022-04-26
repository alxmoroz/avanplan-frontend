#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC

from ..base_schema import PKGetable, PKUpsertable, Titleable


class _WSRoleSchema(Titleable, ABC):
    pass


class WSRoleSchemaGet(_WSRoleSchema, PKGetable):
    pass


class WSRoleSchemaUpsert(_WSRoleSchema, PKUpsertable):
    pass
