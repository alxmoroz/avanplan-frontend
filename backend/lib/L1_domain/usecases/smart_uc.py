#  Copyright (c) 2022. Alexandr Moroz
from typing import TypeVar

from ..entities import Smartable
from ..repositories.abstract_entity_repo import SUpd
from .base_db_uc import BaseDBUC

E = TypeVar("E", bound=Smartable)


class SmartUC(BaseDBUC[E]):
    def upsert(self, s: SUpd) -> E:
        data = self.e_repo.dict_from_schema_upd(s)
        # TODO: возможное место для логики определения открыто/закрыто по статусу
        return self.e_repo.entity_from_orm(self.db_repo.upsert(data))
