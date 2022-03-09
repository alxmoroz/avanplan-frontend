#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import Column, DateTime, String

from ..base_model import Importable, Timestampable


class Smartable(Timestampable, Importable):

    title = Column(String, nullable=False)
    description = Column(String)
    due_date = Column(DateTime)
