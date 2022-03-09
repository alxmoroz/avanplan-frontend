#  Copyright (c) 2022. Alexandr Moroz
from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Goal
from lib.L1_domain.entities.goals.goal_import import GoalImport
from lib.L2_data.models import Goal as GoalModel
from lib.L2_data.schema import GoalSchema
from lib.L2_data.schema.goals.smartable import Smartable

from ..db_repo import DBRepo


class GoalRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(GoalModel, GoalSchema, Goal, db)

    # TODO: ?
    def entity_from_schema(self, s: GoalSchema) -> Goal:
        s = Smartable(**s.dict())
        return super().entity_from_schema(s)


# TODO: наверное, это должно быть в репозитории импорта и отдельная схема просто. Такая сущность это не ок
class GoalImportRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(GoalModel, GoalSchema, GoalImport, db)

    # TODO: ?
    def entity_from_schema(self, s: GoalSchema) -> Goal:
        s = Smartable(**s.dict())
        return super().entity_from_schema(s)

    def schema_from_entity(self, e: GoalImport) -> GoalSchema:

        s: GoalSchema = GoalSchema(
            parent_id=e.parent.id if e.parent else None,
            status_id=e.status.id if e.status else None,
            **jsonable_encoder(e),
        )

        return s
