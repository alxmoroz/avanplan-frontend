#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import User
from lib.L2_data.models.auth import User as UserModel
from lib.L2_data.schema import UserSchemaGet, UserSchemaUpsert

from ..base_mapper import BaseMapper


class UserMapper(BaseMapper[UserSchemaGet, UserSchemaUpsert, User, UserModel]):
    def __init__(self):
        super().__init__(schema_get_cls=UserSchemaGet, schema_upd_cls=UserSchemaUpsert, entity_cls=User)
