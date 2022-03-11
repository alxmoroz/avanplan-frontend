#  Copyright (c) 2022. Alexandr Moroz
from datetime import datetime

from pydantic import EmailStr
from sqlalchemy import column

from lib.L1_domain.entities import User
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.schema import UserSchema


def test_get_one(user_repo: UserRepo, tmp_user: User):
    obj_out = user_repo.get_one(id=tmp_user.id)
    assert tmp_user == obj_out


def test_get_create(user_repo: UserRepo, tmp_user: User):

    obj2 = user_repo.create(UserSchema(email=EmailStr("test@mail.com"), password="pass"))

    objects = user_repo.get(
        limit=2,
        where=column("id").in_([tmp_user.id, obj2.id]),
    )
    assert tmp_user in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert user_repo.delete(obj2.id) == 1


def test_update(user_repo: UserRepo, tmp_user: User):
    s = UserSchema(
        id=tmp_user.id,
        email=EmailStr("test2@mail.com"),
        full_name="full_name",
        password="pass2",
        is_active=False,
        is_superuser=True,
        updated_on=datetime.now(),
    )

    obj_out = user_repo.update(s)
    test_obj_out = user_repo.get_one(id=tmp_user.id)

    assert obj_out == test_obj_out
    assert obj_out.email == s.email
    assert obj_out.full_name == s.full_name
    assert obj_out.password == s.password
    assert obj_out.is_active == s.is_active
    assert obj_out.is_superuser == s.is_superuser
    assert obj_out.updated_on == s.updated_on


def test_upsert_delete(user_repo: UserRepo):
    # upsert
    user = User(email=EmailStr("test3@mail.com"), password="pass")
    obj_out = user_repo.update(UserSchema(email=EmailStr(user.email), password=user.password))
    test_obj_out = user_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert user.email == obj_out.email

    # delete
    assert user_repo.delete(obj_out.id) == 1
