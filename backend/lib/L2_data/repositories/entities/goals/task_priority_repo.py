#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import TaskPriority
from lib.L2_data.models import TaskPriority as TPModel
from lib.L2_data.schema import TaskPrioritySchema

from ..entity_repo import EntityRepo


class TaskPriorityRepo(EntityRepo[TaskPrioritySchema, TaskPrioritySchema, TaskPriority, TPModel]):
    def __init__(self):
        super().__init__(schema_get_cls=TaskPrioritySchema, entity_cls=TaskPriority)
