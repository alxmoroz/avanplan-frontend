#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import MilestoneStatus
from lib.L2_data.models import MilestoneStatus as MilestoneStatusModel

from ..db_repo import DBRepo


class MilestoneStatusRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(MilestoneStatusModel, MilestoneStatus, db)
