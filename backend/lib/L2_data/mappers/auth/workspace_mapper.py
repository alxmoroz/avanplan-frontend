#  Copyright (c) 2022. Alexandr Moroz


from lib.L1_domain.entities import Workspace

from ...models.auth import Workspace as WSModel
from ...schema import WorkspaceSchemaGet, WorkspaceSchemaUpsert
from ..base_mapper import BaseMapper
from ..goals import GoalMapper, PersonMapper, RemoteTrackerMapper, TaskPriorityMapper, TaskStatusMapper


class WorkspaceMapper(BaseMapper[WorkspaceSchemaGet, WorkspaceSchemaUpsert, Workspace, WSModel]):
    def __init__(self):
        super().__init__(schema_get_cls=WorkspaceSchemaGet, schema_upd_cls=WorkspaceSchemaUpsert, entity_cls=Workspace)

    def entity_from_schema_get(self, s: WorkspaceSchemaGet) -> Workspace | None:

        if s:
            w: Workspace = super().entity_from_schema_get(s)
            w.goals = [GoalMapper().entity_from_schema_get(g) for g in s.goals]
            w.task_statuses = [TaskStatusMapper().entity_from_schema_get(ts) for ts in s.task_statuses]
            w.task_priorities = [TaskPriorityMapper().entity_from_schema_get(tp) for tp in s.task_priorities]
            w.persons = [PersonMapper().entity_from_schema_get(p) for p in s.persons]
            w.remote_trackers = [RemoteTrackerMapper().entity_from_schema_get(m) for m in s.remote_trackers]
            return w
