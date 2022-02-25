#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy.orm import Session

from lib.L1_domain.entities.tracker import Project, ProjectStatus
from lib.L2_data.models import Project as ProjectModel
from lib.L2_data.models import ProjectStatus as ProjectStatusModel
from lib.L2_data.repositories import DBRepo


class ProjectRepo(DBRepo[ProjectModel, Project]):
    def __init__(self, db: Session):
        super().__init__(ProjectModel, Project, db)


class ProjectStatusRepo(DBRepo):
    def __init__(self, db: Session):
        super().__init__(ProjectStatusModel, ProjectStatus, db)
