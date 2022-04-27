#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, ForeignKey, Integer
from sqlalchemy.orm import relationship

from ..base_model import BaseModel


class WSUserRole(BaseModel):

    workspace_id = Column(Integer, ForeignKey("workspaces.id", ondelete="CASCADE"))
    workspace = relationship("Workspace")

    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"))
    user = relationship("User")

    ws_role_id = Column(Integer, ForeignKey("wsroles.id", ondelete="CASCADE"))
    ws_role = relationship("WSRole")
