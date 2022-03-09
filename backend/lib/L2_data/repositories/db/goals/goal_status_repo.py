#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities import GoalStatus
from lib.L2_data.models import GoalStatus as GoalStatusModel
from lib.L2_data.schema import GoalStatusSchema

from ..db_repo import DBRepo


class GoalStatusRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(GoalStatusModel, GoalStatusSchema, GoalStatus, db)
