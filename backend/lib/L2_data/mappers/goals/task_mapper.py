#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities.goals import Task
from lib.L2_data.models import Task as TaskModel
from lib.L2_data.schema import TaskSchemaGet, TaskSchemaUpsert

from ..base_mapper import BaseMapper
from .person_mapper import PersonMapper
from .task_priority_mapper import TaskPriorityMapper
from .task_status_mapper import TaskStatusMapper


class TaskMapper(BaseMapper[TaskSchemaGet, TaskSchemaUpsert, Task, TaskModel]):
    def __init__(self):
        super().__init__(
            schema_get_cls=TaskSchemaGet,
            schema_upd_cls=TaskSchemaUpsert,
            entity_cls=Task,
        )

    def entity_from_schema_get(self, s: TaskSchemaGet) -> Task | None:

        if s:
            t: Task = super().entity_from_schema_get(s)
            t.status = TaskStatusMapper().entity_from_schema_get(s.status)
            t.priority = TaskPriorityMapper().entity_from_schema_get(s.priority)
            t.assignee = PersonMapper().entity_from_schema_get(s.assignee)
            t.author = PersonMapper().entity_from_schema_get(s.author)
            t.tasks = [self.entity_from_schema_get(ts) for ts in s.tasks]
            return t
