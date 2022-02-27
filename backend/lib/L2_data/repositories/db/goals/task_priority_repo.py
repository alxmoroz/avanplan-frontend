#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import TaskPriority
from lib.L2_data.models import TaskPriority as TaskPriorityModel

from ..db_repo import DBRepo


class TaskPriorityRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(TaskPriorityModel, TaskPriority, db)
