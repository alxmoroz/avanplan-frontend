#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities.goals import Task
from lib.L2_data.schema import TaskSchemaCreate, TaskSchemaGet

from ..entity_repo import EntityRepo
from .person_repo import PersonRepo
from .task_priority_repo import TaskPriorityRepo
from .task_status_repo import TaskStatusRepo


class TaskRepo(EntityRepo):
    def __init__(self):
        super().__init__(
            schema_get_cls=TaskSchemaGet,
            schema_create_cls=TaskSchemaCreate,
            entity_cls=Task,
        )

    def entity_from_schema(self, s: TaskSchemaGet) -> Task | None:

        if s:
            t: Task = super().entity_from_schema(s)
            t.status = TaskStatusRepo().entity_from_schema(s.status)
            t.author = PersonRepo().entity_from_schema(s.author)
            t.assignee = PersonRepo().entity_from_schema(s.assignee)
            t.priority = TaskPriorityRepo().entity_from_schema(s.priority)
            return t
