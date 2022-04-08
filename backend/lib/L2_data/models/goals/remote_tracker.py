#  Copyright (c) 2022. Alexandr Moroz


from sqlalchemy import Column, ForeignKey, Integer, String

from ..base_model import BaseModel, TitleableUnique


class RemoteTrackerType(TitleableUnique, BaseModel):
    pass


class RemoteTracker(TitleableUnique, BaseModel):
    remote_tracker_type_id = Column(Integer, ForeignKey("remotetrackertypes.id"))
    url = Column(String, nullable=False)
    login_key = Column(String, nullable=False)
    password = Column(String)
