#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models import Task as TaskModel
from lib.L2_data.repositories import entities as er

from ..db_repo import DBRepo


class TaskImportRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(
            model_cls=TaskModel,
            entity_repo=er.TaskImportRepo(),
            db=db,
        )
