#  Copyright (c) 2022. Alexandr Moroz
from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Goal
from lib.L1_domain.entities.goals.goal_import import GoalImport
from lib.L2_data.models import Goal as GoalModel
from lib.L2_data.schema import GoalSchemaCreate, GoalSchemaGet

from ..db_repo import DBRepo


class GoalRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(GoalModel, GoalSchemaGet, GoalSchemaCreate, Goal, db)


# TODO: наверное, это должно быть в репозитории импорта и отдельная схема просто. Такая сущность это не ок
class GoalImportRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(GoalModel, GoalSchemaGet, GoalSchemaCreate, GoalImport, db)

    def schema_from_entity(self, e: GoalImport) -> GoalSchemaCreate:

        s = GoalSchemaCreate(
            parent_id=e.parent.id if e.parent else None,
            status_id=e.status.id if e.status else None,
            **jsonable_encoder(e),
        )

        return s
