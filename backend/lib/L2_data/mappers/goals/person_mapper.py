#  Copyright (c) 2022. Alexandr Moroz
from fastapi.encoders import jsonable_encoder

from lib.L1_domain.entities.goals import Person
from lib.L2_data.models import Person as PersonModel
from lib.L2_data.schema import PersonSchemaGet, PersonSchemaUpsert

from ..auth import WorkspaceMapper
from ..base_mapper import BaseMapper


class PersonMapper(BaseMapper[PersonSchemaGet, PersonSchemaUpsert, Person, PersonModel]):
    def __init__(self):
        super().__init__(schema_get_cls=PersonSchemaGet, schema_upd_cls=PersonSchemaUpsert, entity_cls=Person)

    def entity_from_schema_get(self, s: PersonSchemaGet) -> Person | None:
        if s:
            p: Person = super().entity_from_schema_get(s)
            p.workspace = WorkspaceMapper().entity_from_schema_get(s.workspace)
            return p

    def schema_upd_from_entity(self, e: Person) -> PersonSchemaUpsert:
        data = jsonable_encoder(e)
        s = PersonSchemaUpsert(
            **data,
            workspace_id=e.workspace.id if e.workspace else None,
        )
        return s
