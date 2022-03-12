#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC
from typing import Generic, Type, TypeVar

M = TypeVar("M")


class AbstractDBRepo(Generic[M], ABC):
    def __init__(self, *, model_cls: Type[M]):
        self._model_class = model_cls

    def get(
        self,
        *,
        where: any = None,
        skip: int = 0,
        limit: int | None = None,
        **filter_by,
    ) -> list[M]:
        raise NotImplementedError

    # TODO: возможно, стоит использовать промежуточный результат rows из SA
    def get_one(self, **filter_by) -> M | None:
        objs = self.get(**filter_by)
        return objs[0] if len(objs) > 0 else None

    def create(self, data: dict) -> M:
        raise NotImplementedError

    def update(self, data: dict) -> M:
        raise NotImplementedError

    def delete(self, pk_id: int) -> int:
        raise NotImplementedError
