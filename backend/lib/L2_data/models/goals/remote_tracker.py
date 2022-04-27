#  Copyright (c) 2022. Alexandr Moroz


from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship

from ..base_model import BaseModel, TitleableUnique, WorkspaceBound


class RemoteTrackerType(TitleableUnique, BaseModel):
    pass


class RemoteTracker(WorkspaceBound, BaseModel):
    remote_tracker_type_id = Column(Integer, ForeignKey("remotetrackertypes.id"))
    type = relationship("RemoteTrackerType")
    url = Column(String, nullable=False)
    login_key = Column(String, nullable=False)
    password = Column(String)
    description = Column(String)
