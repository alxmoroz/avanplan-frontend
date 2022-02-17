#  Copyright (c) 2022. Alexandr Moroz

from typing import Generic, Type, TypeVar

from ..entities.base_entity import IdentifiableEntity


class AbstractModel:
    __abstract__ = True


E = TypeVar("E", bound=IdentifiableEntity)
M = TypeVar("M", bound=AbstractModel)


class AbstractDBRepo(Generic[M, E]):
    __abstract__ = True

    def __init__(self, model: Type[M], entity: Type[E]):
        self.model = model
        self.entity = entity

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
    def get_one(
        self,
        **filter_by,
    ) -> E | None:
        objs = self.get(**filter_by)
        return objs[0] if len(objs) > 0 else None

    def create(self, e: E) -> E:
        raise NotImplementedError

    def update(self, e: E) -> int:
        raise NotImplementedError

    def delete(self, e: E):
        raise NotImplementedError
