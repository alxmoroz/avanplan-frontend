#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import TaskStatus
from lib.L2_data.models import TaskStatus as TaskStatusModel
from lib.L2_data.schema import TaskStatusSchema

from ..db_repo import DBRepo


class TaskStatusRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(TaskStatusModel, TaskStatusSchema, TaskStatusSchema, TaskStatus, db)
