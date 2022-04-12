#  Copyright (c) 2022. Alexandr Moroz
from abc import ABC
from typing import Generic, TypeVar

from ..entities.api.exceptions import ApiException
from ..entities.base_entity import Persistable
from ..repositories.abstract_db_repo import AbstractDBRepo
from ..repositories.abstract_mapper import AbstractMapper, SUpd

E = TypeVar("E", bound=Persistable)


class BaseDBUC(Generic[E], ABC):
    def __init__(
        self,
        db_repo: AbstractDBRepo,
        e_repo: AbstractMapper,
    ):
        self.db_repo = db_repo
        self.e_repo = e_repo

    def get_one(self, **filter_by) -> E | None:
        obj = self.db_repo.get_one(**filter_by)
        if obj:
            return self.e_repo.entity_from_orm(obj)

    def get_all(self) -> list[E]:
        return [self.e_repo.entity_from_orm(db_obj) for db_obj in self.db_repo.get()]

    def upsert(self, s: SUpd) -> E:

        data = self.e_repo.dict_from_schema_upd(s)
        return self.e_repo.entity_from_orm(self.db_repo.upsert(data))

    def delete(self, pk_id: int) -> int:
        deleted_count = self.db_repo.delete(pk_id)
        if deleted_count != 1:
            raise ApiException(400, f"Error deleting {self.db_repo.model_class} id = {pk_id}")
        return deleted_count
