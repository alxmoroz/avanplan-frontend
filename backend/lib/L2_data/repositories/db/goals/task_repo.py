#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Task
from lib.L2_data.models import Task as TaskModel
from lib.L2_data.schema import TaskSchema
from lib.L2_data.schema.goals.smartable import Smartable

from ..db_repo import DBRepo


class TaskRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(TaskModel, TaskSchema, Task, db)

    # TODO: ?
    def entity_from_schema(self, s: TaskSchema) -> Task:
        s = Smartable(**s.dict())
        return super().entity_from_schema(s)
