#  Copyright (c) 2022. Alexandr Moroz

from typing import Type, TypeVar

from fastapi.encoders import jsonable_encoder
from pydantic import BaseModel as BaseSchemaModel

from lib.L1_domain.repositories.abstract_mapper import AbstractMapper, E
from lib.L2_data.repositories.db.db_repo import M

SGet = TypeVar("SGet", bound=BaseSchemaModel)
SUpd = TypeVar("SUpd", bound=BaseSchemaModel)


# TODO: возможно, будет лучше эти "репы" перенести в схемы... Или туда, где обрабатываются эти объекты. Уменьшим количество файлов "реп"
#  потому что это даже не репы вовсе, а в лучшем случае мапперы


class BaseMapper(AbstractMapper[SGet, SUpd, E, M]):
    def __init__(
        self,
        *,
        schema_get_cls: Type[SGet],
        schema_upd_cls: Type[SUpd],
        entity_cls: Type[E],
    ):
        super().__init__(
            schema_get_cls=schema_get_cls,
            schema_upd_cls=schema_upd_cls,
            entity_cls=entity_cls,
        )

    def entity_from_schema_get(self, s: SGet) -> E | None:
        if s:
            return self._entity_cls(**s.dict())

    def dict_from_schema_upd(self, s: SUpd) -> dict:
        return jsonable_encoder(s)

    def schema_upd_from_entity(self, e: E) -> SUpd:
        return self._schema_upd_cls(**jsonable_encoder(e))

    def entity_from_orm(self, db_obj: M) -> E:
        s = self._schema_get_cls.from_orm(db_obj)
        return self.entity_from_schema_get(s)
