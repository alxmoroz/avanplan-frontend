#  Copyright (c) 2022. Alexandr Moroz

from typing import Generic, Type, TypeVar

from ..entities.base_entity import Identifiable

M = TypeVar("M")
S = TypeVar("S")
E = TypeVar("E", bound=Identifiable)


class AbstractDBRepo(Generic[M, S, E]):
    def __init__(
        self,
        model_class: Type[M],
        schema_get_class: Type[S],
        schema_create_class: Type[S],
        entity_class: Type[E],
    ):
        self._model_class = model_class
        self._schema_get_class = schema_get_class
        self._schema_create_class = schema_create_class
        self._entity_class = entity_class

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

    def create(self, data: S) -> E:
        raise NotImplementedError

    def update(self, data: S) -> E:
        raise NotImplementedError

    def delete(self, pk_id: int) -> int:
        raise NotImplementedError

    def schema_from_entity(self, e: E) -> S:
        raise NotImplementedError
