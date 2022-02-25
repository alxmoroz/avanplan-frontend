#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.tracker import Task, TaskPriority, TaskStatus
from lib.L2_data.models import Task as TaskModel
from lib.L2_data.models import TaskPriority as TaskPriorityModel
from lib.L2_data.models import TaskStatus as TaskStatusModel
from lib.L2_data.repositories import DBRepo


class TaskRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(TaskModel, Task, db)


class TaskStatusRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(TaskStatusModel, TaskStatus, db)


class TaskPriorityRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(TaskPriorityModel, TaskPriority, db)
