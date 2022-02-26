#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.tracker import Goal, GoalStatus
from lib.L2_data.models import Goal as GoalModel
from lib.L2_data.models import GoalStatus as GoalStatusModel
from lib.L2_data.repositories import DBRepo


class GoalRepo(DBRepo[GoalModel, Goal]):
    def __init__(self, db: Session):
        super().__init__(GoalModel, Goal, db)


class GoalStatusRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(GoalStatusModel, GoalStatus, db)
