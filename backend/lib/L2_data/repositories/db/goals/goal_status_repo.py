#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models import GoalStatus
from lib.L2_data.repositories import entities as er

from ..db_repo import DBRepo


class GoalStatusRepo(DBRepo):
    def __init__(self, db: Session | None):
        super().__init__(
            model_cls=GoalStatus,
            entity_repo=er.GoalStatusRepo(),
            db=db,
        )
