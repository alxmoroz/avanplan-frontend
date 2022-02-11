#  Copyright (c) 2022. Alexandr Moroz

from typing import Generic, Type, TypeVar

from lib.L1_domain.entities.base_entity import BaseEntity


class AbstractModel:
    pass


E = TypeVar("E", bound=BaseEntity)
M = TypeVar("M", bound=AbstractModel)


class AbstractDBRepo(Generic[M, E]):
    def __init__(self, model: Type[M], entity: Type[E]):
        self.model = model
        self.entity = entity

    def get(
        self,
        *,
        limit: int | None = None,
        skip: int = 0,
        **filter_by,
    ) -> list[E]:
        pass

    # TODO: возможно, стоит использовать промежуточный результат rows из SA
    def get_one(
        self,
        **filter_by,
    ) -> E | None:
        objs = self.get(**filter_by)
        return objs[0] if len(objs) > 0 else None

    def create(self, e: E) -> E:
        pass

    def update(self, e: E) -> int:
        pass

    def delete(self, e: E):
        pass
