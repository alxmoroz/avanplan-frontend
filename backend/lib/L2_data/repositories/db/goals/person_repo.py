#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L2_data.models import Person as PersonModel
from lib.L2_data.repositories import entities as er

from ..db_repo import DBRepo


class PersonRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(
            model_cls=PersonModel,
            entity_repo=er.PersonRepo(),
            db=db,
        )
