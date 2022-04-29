#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass


@dataclass
class WorkspaceBounded:
    workspace_id: int = None
