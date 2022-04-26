#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models.auth import WSRole

from ..db_repo import DBRepo


class WSRoleRepo(DBRepo[WSRole]):
    def __init__(self, db: Session):
        super().__init__(model_cls=WSRole, db=db)
