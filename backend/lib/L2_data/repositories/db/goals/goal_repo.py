#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models import Goal as GoalModel

from ..db_repo import DBRepo


class GoalRepo(DBRepo[GoalModel]):
    def __init__(self, db: Session):
        super().__init__(model_cls=GoalModel, db=db)
