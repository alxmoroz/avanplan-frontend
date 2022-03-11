#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import GoalStatus
from lib.L2_data.schema import GoalStatusSchema

from ..entity_repo import EntityRepo


class GoalStatusRepo(EntityRepo):
    def __init__(self):
        super().__init__(
            schema_get_cls=GoalStatusSchema,
            entity_cls=GoalStatus,
        )
