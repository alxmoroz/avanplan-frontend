#  Copyright (c) 2022. Alexandr Moroz

from typing import Union

from sqlalchemy.orm import Session

from lib.L1_domain.entities.auth import CreateUser, UpdateUser
from lib.L2_app.extra.security import get_password_hash, verify_password

from ..models.auth import User
from .base_db_repo import BaseDBRepo

# TODO: нужен соотв. репозиторий в Л1


class UserDBRepo(BaseDBRepo[User, CreateUser, UpdateUser]):
    @staticmethod
    def get_by_email(db: Session, *, email: str) -> User | None:
        return db.query(User).filter(User.email == email).first()

    def create(self, db: Session, *, obj_in: CreateUser) -> User:
        db_user = User(**obj_in.dict(exclude={"password"}))  # type: ignore
        db_user.hashed_password = get_password_hash(obj_in.password)
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user

    def update(
        self, db: Session, *, db_obj: User, obj_in: Union[UpdateUser, dict[str, any]]
    ) -> User:
        if isinstance(obj_in, dict):
            update_data = obj_in
        else:
            update_data = obj_in.dict(exclude_unset=True)
        if update_data["password"]:
            hashed_password = get_password_hash(update_data["password"])
            del update_data["password"]
            update_data["hashed_password"] = hashed_password
        return super().update(db, db_obj=db_obj, obj_in=update_data)

    def authenticate(self, db: Session, *, email: str, password: str) -> User | None:
        db_user = self.get_by_email(db, email=email)
        if not db_user:
            return None
        if not verify_password(password, db_user.hashed_password):
            return None
        return db_user
