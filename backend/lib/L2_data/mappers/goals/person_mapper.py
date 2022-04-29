#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities.goals import Person
from lib.L2_data.models import Person as PersonModel
from lib.L2_data.schema import PersonSchemaGet, PersonSchemaUpsert

from ..base_mapper import BaseMapper


class PersonMapper(BaseMapper[PersonSchemaGet, PersonSchemaUpsert, Person, PersonModel]):
    def __init__(self):
        super().__init__(schema_get_cls=PersonSchemaGet, schema_upd_cls=PersonSchemaUpsert, entity_cls=Person)
