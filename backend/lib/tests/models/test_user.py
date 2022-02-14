#  Copyright (c) 2022. Alexandr Moroz
from sqlalchemy import column

from lib.L2_data.repositories import SecurityRepo, UserRepo
from lib.tests.models.utils_user import tmp_user


def test_get_user(user_repo: UserRepo):
    with tmp_user(user_repo) as user:
        user_out = user_repo.get_one(id=user.id)
        assert user == user_out


def test_get_users(user_repo: UserRepo):
    with tmp_user(user_repo) as u1, tmp_user(user_repo) as u2:
        users = user_repo.get(
            limit=2,
            where=column("id").in_([u1.id, u2.id]),
        )
        assert u1 in users
        assert u2 in users
        assert len(users) == 2


def test_create_user(user_repo: UserRepo):

    password = "password"
    with tmp_user(user_repo, password=password) as user:
        user_out = user_repo.get_one(id=user.id)

        assert user == user_out
        assert user.password != password
        assert SecurityRepo.verify_password(password, user.password)


def test_update_user(user_repo: UserRepo):
    with tmp_user(user_repo) as user_in:
        new_full_name = "full_name"
        user_in.full_name = new_full_name

        updated_rows = user_repo.update(user_in)
        user_out = user_repo.get_one(id=user_in.id)

        assert updated_rows == 1
        assert user_in == user_out
        assert user_out.full_name == new_full_name


def test_delete_user(user_repo: UserRepo):
    with tmp_user(user_repo) as user:
        assert user_repo.delete(user) == 1
