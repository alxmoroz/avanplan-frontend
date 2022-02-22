#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities.tracker import Project
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories import ProjectRepo, SecurityRepo, UserRepo
from lib.L2_data.repositories.security_repo import oauth2_scheme

router = APIRouter(prefix="/tracker")


@router.post("/projects", response_model=list[Project])
def projects(
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(db_session),
) -> list[Project]:

    # TODO: не очень DRY получилось тут
    UsersUC(UserRepo(db), SecurityRepo(token)).get_active_user()

    # TODO: юзкейс? В данном случае пока что не требуется — Пригодится, если вручную собирать из разных реп что-то нужно будет...
    return ProjectRepo(db).get()
