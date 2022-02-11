#  Copyright (c) 2022. Alexandr Moroz
from lib.L1_domain.entities.tracker import Project

from ..models.tracker.project import Project as ProjectModel
from ..models.users import User
from .db_repo import DBRepo
from .security_repo import SecurityRepo
from .user_db_repo import UserDBRepo

user_repo = UserDBRepo(User)
project_repo = DBRepo(ProjectModel, Project)
security_repo = SecurityRepo()
