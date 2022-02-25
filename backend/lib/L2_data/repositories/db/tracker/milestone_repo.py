#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.tracker import Milestone, MilestoneStatus
from lib.L2_data.models import Milestone as MilestoneModel
from lib.L2_data.models import MilestoneStatus as MilestoneStatusModel
from lib.L2_data.repositories import DBRepo


class MilestoneRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(MilestoneModel, Milestone, db)


class MilestoneStatusRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(MilestoneStatusModel, MilestoneStatus, db)
