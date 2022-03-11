#  Copyright (c) 2022. Alexandr Moroz

from typing import Type, TypeVar

from fastapi.encoders import jsonable_encoder
from pydantic import BaseModel as BaseSchemaModel

from lib.L1_domain.repositories.abstract_entity_repo import AbstractEntityRepo, E

SGet = TypeVar("SGet", bound=BaseSchemaModel)
SCreate = TypeVar("SCreate", bound=BaseSchemaModel)


class EntityRepo(AbstractEntityRepo[SGet, SCreate, E]):
    def __init__(
        self,
        *,
        schema_get_cls: Type[SGet],
        schema_create_cls: Type[SCreate] | None = None,
        entity_cls: Type[E],
    ):
        super().__init__(
            schema_get_cls=schema_get_cls,
            schema_create_cls=schema_create_cls or schema_get_cls,
            entity_cls=entity_cls,
        )

    def entity_from_schema(self, s: SGet) -> E | None:
        if s:
            return self._entity_cls(**s.dict())

    def schema_from_entity(self, e: E) -> SCreate:
        return self._schema_create_cls(**jsonable_encoder(e))
