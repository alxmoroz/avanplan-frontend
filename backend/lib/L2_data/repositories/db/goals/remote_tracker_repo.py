#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models import RemoteTracker

from ..db_repo import DBRepo


class RemoteTrackerRepo(DBRepo[RemoteTracker]):
    def __init__(self, db: Session):
        super().__init__(model_cls=RemoteTracker, db=db)
