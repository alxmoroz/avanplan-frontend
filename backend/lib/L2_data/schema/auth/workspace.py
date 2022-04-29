#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC

from ..base_schema import PKGetable, PKUpsertable, Titleable
from ..goals import GoalSchemaGet, PersonSchemaGet, RemoteTrackerSchemaGet, TaskPrioritySchemaGet, TaskStatusSchemaGet


class _WorkspaceSchema(Titleable, ABC):
    pass


class WorkspaceSchemaGet(_WorkspaceSchema, PKGetable):
    goals: list[GoalSchemaGet] = None
    task_statuses: list[TaskStatusSchemaGet] = None
    task_priorities: list[TaskPrioritySchemaGet] = None
    persons: list[PersonSchemaGet] = None
    remote_trackers: list[RemoteTrackerSchemaGet] = None


class WorkspaceSchemaUpsert(_WorkspaceSchema, PKUpsertable):
    pass
