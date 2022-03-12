#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder

from lib.L1_domain.entities import GoalImport
from lib.L2_data.models import Goal as GoalModel
from lib.L2_data.schema import GoalImportSchemaGet, GoalSchemaCreate

from ..entity_repo import EntityRepo


# TODO: наверное, это должно быть в репозитории импорта и отдельная схема просто. Такая сущность это не ок
class GoalImportRepo(EntityRepo[GoalImportSchemaGet, GoalSchemaCreate, GoalImport, GoalModel]):
    def __init__(self):
        super().__init__(
            schema_get_cls=GoalImportSchemaGet,
            schema_create_cls=GoalSchemaCreate,
            entity_cls=GoalImport,
        )

    def entity_from_schema_get(self, s: GoalImportSchemaGet) -> GoalImport | None:
        if s:
            g: GoalImport = super().entity_from_schema_get(s)
            g.parent = self.entity_from_schema_get(s.parent)
            return g

    def schema_create_from_entity(self, e: GoalImport) -> GoalSchemaCreate:

        s = GoalSchemaCreate(
            parent_id=e.parent.id if e.parent else None,
            status_id=e.status.id if e.status else None,
            **jsonable_encoder(e),
        )

        return s
