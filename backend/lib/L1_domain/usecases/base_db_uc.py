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
        *,
        repo: AbstractDBRepo,
        mapper: AbstractMapper,
    ):
        self.repo = repo
        self.mapper = mapper

    def get_one(self, **filter_by) -> E | None:
        obj = self.repo.get_one(**filter_by)
        if obj:
            return self.mapper.entity_from_orm(obj)

    def get_all(self, *, where=None, **filter_by) -> list[E]:
        return [self.mapper.entity_from_orm(db_obj) for db_obj in self.repo.get(where=where, **filter_by)]

    def upsert(self, s: SUpd) -> E:

        data = self.mapper.dict_from_schema_upd(s)
        return self.mapper.entity_from_orm(self.repo.upsert(data))

    def delete(self, pk_id: int) -> int:
        deleted_count = self.repo.delete(pk_id)
        if deleted_count != 1:
            raise ApiException(400, f"Error deleting {self.repo.model_class} id = {pk_id}")
        return deleted_count
