#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Boolean, Column, DateTime, ForeignKey, Integer, String
from sqlalchemy.orm import declared_attr, relationship


class Smartable:
    __abstract__ = True

    title = Column(String, nullable=False)
    description = Column(String)

    created_on = Column(DateTime(timezone=True), nullable=False)
    updated_on = Column(DateTime(timezone=True), nullable=False)
    due_date = Column(DateTime(timezone=True))
    closed = Column(Boolean, nullable=False)

    @declared_attr
    def assignee_id(self):
        return Column(Integer, ForeignKey("persons.id", ondelete="SET NULL"))

    @declared_attr
    def assignee(self):
        return relationship("Person", foreign_keys=[self.assignee_id])

    @declared_attr
    def author_id(self):
        return Column(Integer, ForeignKey("persons.id", ondelete="SET NULL"))

    @declared_attr
    def author(self):
        return relationship("Person", foreign_keys=[self.author_id])

    remote_code = Column(String)

    @declared_attr
    def remote_tracker_id(self):
        return Column(Integer, ForeignKey("remotetrackers.id", ondelete="SET NULL"))

    @declared_attr
    def remote_tracker(self):
        return relationship("RemoteTracker")
