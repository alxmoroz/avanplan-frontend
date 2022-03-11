#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC, abstractmethod
from typing import Generic, Type, TypeVar

SGet = TypeVar("SGet")
SCreate = TypeVar("SCreate")
E = TypeVar("E")


class AbstractEntityRepo(Generic[SGet, SCreate, E], ABC):
    def __init__(
        self,
        *,
        schema_get_cls: Type[SGet],
        schema_create_cls: Type[SCreate],
        entity_cls: Type[E],
    ):
        self._schema_get_cls = schema_get_cls
        self._schema_create_cls = schema_create_cls
        self._entity_cls = entity_cls

    @abstractmethod
    def schema_from_entity(self, e: E) -> SCreate:
        raise NotImplementedError

    @abstractmethod
    def entity_from_schema(self, s: SGet) -> E | None:
        raise NotImplementedError
