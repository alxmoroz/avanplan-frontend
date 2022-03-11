#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models import TaskStatus as TaskStatusModel
from lib.L2_data.repositories import entities as er

from ..db_repo import DBRepo


class TaskStatusRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(
            model_cls=TaskStatusModel,
            entity_repo=er.TaskStatusRepo(),
            db=db,
        )
