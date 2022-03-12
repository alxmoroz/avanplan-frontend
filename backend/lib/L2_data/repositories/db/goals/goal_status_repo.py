#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models import GoalStatus

from ..db_repo import DBRepo


class GoalStatusRepo(DBRepo[GoalStatus]):
    def __init__(self, db: Session | None):
        super().__init__(model_cls=GoalStatus, db=db)
