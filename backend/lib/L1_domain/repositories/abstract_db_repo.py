#  Copyright (c) 2022. Alexandr Moroz
from abc import ABC
from typing import Generic, Type, TypeVar

from ..entities.base_entity import Identifiable
from .abstract_entity_repo import AbstractEntityRepo

M = TypeVar("M")
SCreate = TypeVar("SCreate")
E = TypeVar("E", bound=Identifiable)
ERepo = TypeVar("ERepo", bound=AbstractEntityRepo)


class AbstractDBRepo(Generic[M, SCreate, E], ABC):
    def __init__(
        self,
        *,
        model_cls: Type[M],
        entity_repo: ERepo,
    ):
        self._model_class = model_cls
        self.entity_repo = entity_repo

    def get(
        self,
        *,
        where: any = None,
        skip: int = 0,
        limit: int | None = None,
        **filter_by,
    ) -> list[E]:
        raise NotImplementedError

    # TODO: возможно, стоит использовать промежуточный результат rows из SA
    def get_one(self, **filter_by) -> E | None:
        objs = self.get(**filter_by)
        return objs[0] if len(objs) > 0 else None

    def create(self, data: SCreate) -> E:
        raise NotImplementedError

    def update(self, data: SCreate) -> E:
        raise NotImplementedError

    def delete(self, pk_id: int) -> int:
        raise NotImplementedError
