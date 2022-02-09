#  Copyright (c) 2022. Alexandr Moroz

from ..models.auth import User
from ..models.tracker.project import Project
from .user_repo import BaseDBRepo, UserDBRepo

user_repo = UserDBRepo(User)
project_repo = BaseDBRepo(Project)
