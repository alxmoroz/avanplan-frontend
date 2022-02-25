#  Copyright (c) 2022. Alexandr Moroz
from .base_tracker import BaseTrackerEntity, Importable


class Project(BaseTrackerEntity, Importable):

    parent_id: int | None
    _parent: any

    @property
    def parent(self) -> any:
        return self._parent
