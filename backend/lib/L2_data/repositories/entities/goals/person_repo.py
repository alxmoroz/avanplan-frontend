#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities.goals import Person
from lib.L2_data.schema import PersonSchemaCreate, PersonSchemaGet

from ..entity_repo import EntityRepo


class PersonRepo(EntityRepo):
    def __init__(self):
        super().__init__(
            schema_get_cls=PersonSchemaGet,
            schema_create_cls=PersonSchemaCreate,
            entity_cls=Person,
        )
