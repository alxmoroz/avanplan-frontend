#  Copyright (c) 2022. Alexandr Moroz

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from lib.L1_domain.entities.tracker import Project, Task
from lib.L1_domain.usecases.users_uc import UsersUC
from lib.L2_data.db import db_session
from lib.L2_data.repositories import ProjectRepo, TaskRepo
from lib.L3_app.api.v1.users import user_uc

router = APIRouter(prefix="/tracker")


# TODO: возможно, будет полезно сделать подобие сервисез как на фронте и инициализировать все нужные юзкейсы там и зависимости между ними
#  Также это поможет решить с настройками авторизации, где объект автризации будет юзкейс
#  Тогда ниже не нужно будет импортить базу и юзкейсы отдельно. Будет к примеру, один юзкейс, геттер которого будет зависеть от базы
#  ... и других юзкейсов при необходимости...


@router.post("/projects", response_model=list[Project])
def projects(
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> list[Project]:

    uc.get_active_user()

    return ProjectRepo(db).get()


@router.post("/tasks", response_model=list[Task])
def tasks(
    uc: UsersUC = Depends(user_uc),
    db: Session = Depends(db_session),
) -> list[Project]:

    uc.get_active_user()

    return TaskRepo(db).get()
