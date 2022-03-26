#  Copyright (c) 2022. Alexandr Moroz
from ..entities import Smartable
from ..repositories.abstract_entity_repo import SUpd
from .base_db_uc import BaseDBUC


class SmartUC(BaseDBUC[Smartable]):
    def upsert(self, s: SUpd) -> Smartable:

        data = self.e_repo.dict_from_schema_upd(s)
        return self.e_repo.entity_from_orm(self.db_repo.upsert(data))
