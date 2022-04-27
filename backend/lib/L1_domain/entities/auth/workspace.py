#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..base_entity import Titleable


@dataclass
class Workspace(Titleable):
    pass


@dataclass
class WorkspaceBounded:
    workspace: Workspace = None
