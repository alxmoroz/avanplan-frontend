#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Goal
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

    # def encode_data(self, data: GoalSchema) -> any:
    #
    #     upsert_data = GoalSchema(
    #         parent_id=self.get_id(data.parent) if data.parent else None,
    #         **jsonable_encoder(data),
    #     )
    #     return super().encode_data(upsert_data)
