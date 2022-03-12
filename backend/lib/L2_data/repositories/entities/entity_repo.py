#  Copyright (c) 2022. Alexandr Moroz

from typing import Type, TypeVar

from fastapi.encoders import jsonable_encoder
from pydantic import BaseModel as BaseSchemaModel

from lib.L1_domain.repositories.abstract_entity_repo import AbstractEntityRepo, E
from lib.L2_data.repositories.db.db_repo import M

SGet = TypeVar("SGet", bound=BaseSchemaModel)
SCreate = TypeVar("SCreate", bound=BaseSchemaModel)


# TODO: возможно, будет лучше эти "репы" перенести в схемы... Или туда, где обрабатываются эти объекты. Уменьшим количество файлов "реп"
#  потому что это даже не репы вовсе, а в лучшем случае мапперы


class EntityRepo(AbstractEntityRepo[SGet, SCreate, E, M]):
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

    def entity_from_schema_get(self, s: SGet) -> E | None:
        if s:
            return self._entity_cls(**s.dict())

    def dict_from_schema_create(self, s: SCreate) -> dict:
        return jsonable_encoder(s)

    def schema_create_from_entity(self, e: E) -> SCreate:
        return self._schema_create_cls(**jsonable_encoder(e))

    def entity_from_orm(self, db_obj: M) -> E:
        s = self._schema_get_cls.from_orm(db_obj)
        return self.entity_from_schema_get(s)
