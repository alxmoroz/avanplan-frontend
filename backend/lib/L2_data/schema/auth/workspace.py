#  Copyright (c) 2022. Alexandr Moroz

from abc import ABC

from ..base_schema import PKGetable, PKUpsertable, Titleable


class _WorkspaceSchema(Titleable, ABC):
    pass


class WorkspaceSchemaGet(_WorkspaceSchema, PKGetable):
    pass


class WorkspaceSchemaUpsert(_WorkspaceSchema, PKUpsertable):
    pass
