#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder

from lib.L1_domain.entities import GoalImport
from lib.L2_data.models import Goal as GoalModel
from lib.L2_data.schema import GoalImportSchemaGet, GoalImportSchemaUpsert

from ..base_mapper import BaseMapper
from .person_mapper import PersonMapper


# TODO: наверное, это должно быть в репозитории импорта и отдельная схема просто. Такая сущность это не ок
class GoalImportMapper(BaseMapper[GoalImportSchemaGet, GoalImportSchemaUpsert, GoalImport, GoalModel]):
    def __init__(self):
        super().__init__(
            schema_get_cls=GoalImportSchemaGet,
            schema_upd_cls=GoalImportSchemaUpsert,
            entity_cls=GoalImport,
        )

    def entity_from_schema_get(self, s: GoalImportSchemaGet) -> GoalImport | None:
        if s:
            g: GoalImport = super().entity_from_schema_get(s)
            g.parent = self.entity_from_schema_get(s.parent)
            g.assignee = PersonMapper().entity_from_schema_get(s.assignee)
            g.author = PersonMapper().entity_from_schema_get(s.author)
            return g

    def schema_upd_from_entity(self, e: GoalImport) -> GoalImportSchemaUpsert:

        data = jsonable_encoder(e)
        data.pop("parent_id")
        data.pop("remote_tracker_id")
        s = GoalImportSchemaUpsert(
            **data,
            parent_id=e.parent.id if e.parent else None,
            remote_tracker_id=e.remote_tracker.id if e.remote_tracker else None,
            workspace_id=e.workspace.id if e.workspace else None,
        )

        return s
