#  Copyright (c) 2022. Alexandr Moroz

from .base_tracker import BaseTrackerEntity, Importable, TimeBound


class VersionStatus(BaseTrackerEntity):
    pass


class Version(BaseTrackerEntity, Importable, TimeBound):
    status: VersionStatus
