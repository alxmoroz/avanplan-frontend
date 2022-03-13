#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC, abstractmethod
from typing import Generic, Type, TypeVar

from .abstract_db_repo import M

E = TypeVar("E")
SGet = TypeVar("SGet")
SUpd = TypeVar("SUpd")


class AbstractEntityRepo(Generic[SGet, SUpd, E, M], ABC):
    def __init__(
        self,
        *,
        schema_get_cls: Type[SGet],
        schema_upd_cls: Type[SUpd],
        entity_cls: Type[E],
    ):
        self._schema_get_cls = schema_get_cls
        self._schema_upd_cls = schema_upd_cls
        self._entity_cls = entity_cls

    @abstractmethod
    def dict_from_schema_upd(self, s: SUpd) -> dict:
        raise NotImplementedError

    @abstractmethod
    def schema_upd_from_entity(self, e: E) -> SUpd:
        raise NotImplementedError

    @abstractmethod
    def entity_from_schema_get(self, s: SGet) -> E | None:
        raise NotImplementedError

    @abstractmethod
    def entity_from_orm(self, db_obj: M) -> E:
        raise NotImplementedError
