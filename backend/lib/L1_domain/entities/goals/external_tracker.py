#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass

from ..base_entity import Titleable


@dataclass
class RemoteTrackerType(Titleable):
    pass


@dataclass
class RemoteTracker(Titleable):

    type: RemoteTrackerType | None = None
    url: str = ""
    login_key: str = ""
    password: str | None = None
