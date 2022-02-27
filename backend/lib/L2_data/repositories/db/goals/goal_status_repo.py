#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import GoalStatus
from lib.L2_data.models import GoalStatus as GoalStatusModel

from ..db_repo import DBRepo


class GoalStatusRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(GoalStatusModel, GoalStatus, db)
