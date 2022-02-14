#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import column
from sqlalchemy.orm import Session

from lib.L2_data.repositories import SecurityRepo, UserRepo
from lib.tests.models.utils_user import tmp_user


def test_get_user(db: Session):
    with tmp_user(db) as user:
        user_out = UserRepo(db).get_one(id=user.id)
        assert user == user_out


def test_get_users(db: Session):
    with tmp_user(db) as u1, tmp_user(db) as u2:
        users = UserRepo(db).get(
            limit=2,
            where=column("id").in_([u1.id, u2.id]),
        )
        assert u1 in users
        assert u2 in users
        assert len(users) == 2


def test_create_user(db: Session):

    password = "password"
    with tmp_user(db, password=password) as user:
        user_out = UserRepo(db).get_one(id=user.id)

        assert user == user_out
        assert user.password != password
        assert SecurityRepo.verify_password(password, user.password)


def test_update_user(db: Session):
    with tmp_user(db) as user_in:
        new_full_name = "full_name"
        user_in.full_name = new_full_name
        assert UserRepo(db).update(user_in) == 1

        user_out = UserRepo(db).get_one(id=user_in.id)
        assert user_in == user_out
        assert user_out.full_name == new_full_name


def test_delete_user(db: Session):
    with tmp_user(db) as user:
        assert UserRepo(db).delete(user) == 1
