#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.goals import Person
from lib.L2_data.models import Person as PersonModel
from lib.L2_data.schema import PersonSchema

from ..db_repo import DBRepo


class PersonRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(PersonModel, PersonSchema, PersonSchema, Person, db)
