#  Copyright (c) 2022. Alexandr Moroz

from ..models.users import User
from ..models.tracker.project import Project
from .user_repo import DBRepo, UserDBRepo

user_repo = UserDBRepo(User)
project_repo = DBRepo(Project)
