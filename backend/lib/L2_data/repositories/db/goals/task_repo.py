#  Copyright (c) 2022. Alexandr Moroz
from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Task
from lib.L1_domain.entities.goals.task_import import TaskImport
from lib.L2_data.models import Task as TaskModel
from lib.L2_data.schema import TaskSchema
from lib.L2_data.schema.goals.smartable import Smartable

from ..db_repo import DBRepo


class TaskRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(TaskModel, TaskSchema, TaskSchema, Task, db)

    # TODO: после добавления отдельных схем на чтение и запись, этот метод уже не нужен
    def entity_from_schema(self, s: TaskSchema) -> Task:
        s = Smartable(**s.dict())
        return super().entity_from_schema(s)


class TaskImportRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(TaskModel, TaskSchema, TaskSchema, TaskImport, db)

    # TODO: после добавления отдельных схем на чтение и запись, этот метод уже не нужен
    def entity_from_schema(self, s: TaskSchema) -> Task:
        s = Smartable(**s.dict())
        return super().entity_from_schema(s)

    def schema_from_entity(self, e: TaskImport) -> TaskSchema:

        s: TaskSchema = TaskSchema(
            goal_id=e.goal.id,
            parent_id=e.parent.id if e.parent else None,
            status_id=e.status.id if e.status else None,
            priority_id=e.priority.id if e.priority else None,
            assignee_id=e.assignee.id if e.assignee else None,
            author_id=e.author.id if e.author else None,
            **jsonable_encoder(e),
        )

        return s
