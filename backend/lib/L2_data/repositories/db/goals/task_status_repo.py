#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models import TaskStatus as TaskStatusModel

from ..db_repo import DBRepo


class TaskStatusRepo(DBRepo[TaskStatusModel]):
    def __init__(self, db: Session):
        super().__init__(model_cls=TaskStatusModel, db=db)
