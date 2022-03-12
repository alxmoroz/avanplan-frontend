#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities.goals import TaskStatus
from lib.L2_data.models import TaskStatus as TaskStatusModel
from lib.L2_data.schema import TaskStatusSchema

from ..entity_repo import EntityRepo


class TaskStatusRepo(EntityRepo[TaskStatusSchema, TaskStatusSchema, TaskStatus, TaskStatusModel]):
    def __init__(self):
        super().__init__(schema_get_cls=TaskStatusSchema, entity_cls=TaskStatus)
