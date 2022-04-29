#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import TaskPriority
from lib.L2_data.models import TaskPriority as TPModel
from lib.L2_data.schema import TaskPrioritySchemaGet, TaskPrioritySchemaUpsert

from ..base_mapper import BaseMapper


class TaskPriorityMapper(BaseMapper[TaskPrioritySchemaGet, TaskPrioritySchemaUpsert, TaskPriority, TPModel]):
    def __init__(self):
        super().__init__(schema_get_cls=TaskPrioritySchemaGet, schema_upd_cls=TaskPrioritySchemaUpsert, entity_cls=TaskPriority)
