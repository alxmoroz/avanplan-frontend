#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import BaseMilestone, Milestone
from lib.L2_data.models import Milestone as MilestoneModel

from ..db_repo import DBRepo
from .goal_repo import GoalRepo


class MilestoneUpsertSchema(BaseMilestone):
    goal_id: int | None
    status_id: int | None


class MilestoneRepo(DBRepo):
    def __init__(self, db: Session):
        self.goal_repo = GoalRepo(db)
        super().__init__(MilestoneModel, Milestone, db)

    def _prepare_upsert_data(self, milestone: Milestone) -> any:

        upsert_data = MilestoneUpsertSchema(
            goal_id=milestone.goal.id or self.goal_repo.upsert(milestone.goal).id,
            **milestone.dict(),
        )
        return super()._prepare_upsert_data(upsert_data)
