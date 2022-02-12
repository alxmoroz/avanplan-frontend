#  Copyright (c) 2022. Alexandr Moroz

from lib.L1_domain.entities.tracker import Project
from lib.L1_domain.entities.users import User

from ..models.tracker.project import Project as ProjectModel
from ..models.users import User as UserModel
from .db_repo import DBRepo
from .security_repo import SecurityRepo

user_repo = DBRepo(UserModel, User)
project_repo = DBRepo(ProjectModel, Project)
security_repo: SecurityRepo = SecurityRepo()
