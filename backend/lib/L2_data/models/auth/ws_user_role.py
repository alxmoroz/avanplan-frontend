#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, ForeignKey, Integer

from ..base_model import BaseModel


class WSUserRole(BaseModel):

    workspace_id = Column(Integer, ForeignKey("workspaces.id", ondelete="CASCADE"))
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"))
    ws_role_id = Column(Integer, ForeignKey("wsroles.id", ondelete="CASCADE"))
