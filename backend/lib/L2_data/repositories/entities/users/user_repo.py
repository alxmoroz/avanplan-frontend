#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import User
from lib.L2_data.models import User as UserModel
from lib.L2_data.schema import UserSchemaGet, UserSchemaCreate

from ..entity_repo import EntityRepo


class UserRepo(EntityRepo[UserSchemaGet, UserSchemaCreate, User, UserModel]):
    def __init__(self):
        super().__init__(schema_get_cls=UserSchemaGet, entity_cls=User)
