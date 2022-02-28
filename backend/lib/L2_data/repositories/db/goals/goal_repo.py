#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import BaseSmartPersistent, Goal
from lib.L2_data.models import Goal as GoalModel

from ..db_repo import DBRepo


class GoalUpsertSchema(BaseSmartPersistent):
    parent_id: int | None
    status_id: int | None


class GoalRepo(DBRepo[GoalModel, Goal]):
    def __init__(self, db: Session):
        super().__init__(GoalModel, Goal, db)

    def _prepare_upsert_data(self, goal: Goal) -> any:

        upsert_data = GoalUpsertSchema(
            parent_id=goal.parent.id or self.upsert(goal.parent).id if goal.parent else None,
            **goal.dict(),
        )
        return super()._prepare_upsert_data(upsert_data)
