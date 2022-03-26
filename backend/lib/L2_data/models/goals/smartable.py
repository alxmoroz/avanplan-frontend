#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Boolean, Column, DateTime, String


class Smartable:

    title = Column(String, nullable=False)
    description = Column(String)

    created_on = Column(DateTime(timezone=True), nullable=False)
    updated_on = Column(DateTime(timezone=True), nullable=False)
    due_date = Column(DateTime(timezone=True))
    closed = Column(Boolean, nullable=False)

    remote_code = Column(String)
