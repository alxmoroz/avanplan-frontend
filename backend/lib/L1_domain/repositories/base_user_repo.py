#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities.users import User
from lib.L1_domain.repositories.base_db_repo import BaseDBRepo


class BaseUserRepo(BaseDBRepo[User]):
    pass
