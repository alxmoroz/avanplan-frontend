#  Copyright (c) 2022. Alexandr Moroz
from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Task
from lib.L1_domain.entities.goals.task_import import TaskImport
from lib.L2_data.models import Task as TaskModel
from lib.L2_data.schema import TaskImportSchemaGet, TaskSchemaCreate, TaskSchemaGet

from ..db_repo import DBRepo


class TaskRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(TaskModel, TaskSchemaGet, TaskSchemaCreate, Task, db)


class TaskImportRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(TaskModel, TaskImportSchemaGet, TaskSchemaCreate, TaskImport, db)

    def schema_from_entity(self, e: TaskImport) -> TaskSchemaCreate:

        s = TaskSchemaCreate(
            goal_id=e.goal.id,
            parent_id=e.parent.id if e.parent else None,
            status_id=e.status.id if e.status else None,
            priority_id=e.priority.id if e.priority else None,
            assignee_id=e.assignee.id if e.assignee else None,
            author_id=e.author.id if e.author else None,
            **jsonable_encoder(e),
        )

        return s
