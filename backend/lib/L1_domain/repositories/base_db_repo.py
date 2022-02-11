#  Copyright (c) 2022. Alexandr Moroz

from typing import Generic, TypeVar

from lib.L1_domain.entities.base_entity import BaseEntity

E = TypeVar("E", bound=BaseEntity)


class BaseDBRepo(Generic[E]):
    def get(
        self,
        filter_by: dict,
        limit: int | None = None,
        skip: int = 0,
    ) -> list[E]:
        pass

    def create(self, e: E) -> E:
        pass

    def update(self, e: E) -> int:
        pass

    def delete(self, e: E):
        pass
