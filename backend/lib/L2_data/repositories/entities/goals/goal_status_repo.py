#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import GoalStatus
from lib.L2_data.models import GoalStatus as GoalStatusModel
from lib.L2_data.schema import GoalStatusSchemaGet, GoalStatusSchemaUpsert

from ..entity_repo import EntityRepo


class GoalStatusRepo(EntityRepo[GoalStatusSchemaGet, GoalStatusSchemaUpsert, GoalStatus, GoalStatusModel]):
    def __init__(self):
        super().__init__(schema_get_cls=GoalStatusSchemaGet, schema_upd_cls=GoalStatusSchemaUpsert, entity_cls=GoalStatus)
