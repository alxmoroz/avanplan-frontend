#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..base_entity import Persistable, Titleable


@dataclass
class RemoteTrackerType(Titleable):
    pass


@dataclass
class RemoteTracker(Persistable):

    type: RemoteTrackerType | None = None
    url: str = ""
    login_key: str = ""
    password: str | None = None
    description: str | None = None
