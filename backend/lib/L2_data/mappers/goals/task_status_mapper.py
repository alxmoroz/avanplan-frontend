#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities.goals import TaskStatus
from lib.L2_data.models import TaskStatus as TaskStatusModel
from lib.L2_data.schema import TaskStatusSchemaGet, TaskStatusSchemaUpsert

from ..base_mapper import BaseMapper


class TaskStatusMapper(BaseMapper[TaskStatusSchemaGet, TaskStatusSchemaUpsert, TaskStatus, TaskStatusModel]):
    def __init__(self):
        super().__init__(schema_get_cls=TaskStatusSchemaGet, schema_upd_cls=TaskStatusSchemaUpsert, entity_cls=TaskStatus)
