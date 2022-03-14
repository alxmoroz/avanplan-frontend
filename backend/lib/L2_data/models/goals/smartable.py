#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, DateTime, String


class Smartable:

    title = Column(String, nullable=False)
    description = Column(String)

    created_on = Column(DateTime, nullable=False)
    updated_on = Column(DateTime, nullable=False)
    due_date = Column(DateTime)

    remote_code = Column(String)
