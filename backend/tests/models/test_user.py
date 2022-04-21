#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from pydantic import EmailStr
from sqlalchemy import column

from lib.L2_data.models import User
from lib.L2_data.repositories.db import UserRepo
from lib.L2_data.schema import UserSchemaUpsert


def test_get_one(user_repo: UserRepo, tmp_user: User):
    obj_out = user_repo.get_one(id=tmp_user.id)
    assert tmp_user == obj_out


def test_get_create(user_repo: UserRepo, tmp_user: User):
    s = UserSchemaUpsert(email=EmailStr("test_get_create@mail.com"), password="pass")
    obj2 = user_repo.upsert(jsonable_encoder(s))

    objects = user_repo.get(
        limit=2,
        where=column("id").in_([tmp_user.id, obj2.id]),
    )
    assert tmp_user in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert user_repo.delete(obj2.id) == 1


def test_update(user_repo: UserRepo, tmp_user: User):
    s = UserSchemaUpsert(
        id=tmp_user.id,
        email=EmailStr("test_update@mail.com"),
        full_name="test_update",
        password="pass2",
        is_active=False,
        is_superuser=True,
    )

    obj_out = user_repo.upsert(jsonable_encoder(s))
    test_obj_out = user_repo.get_one(id=tmp_user.id)

    assert obj_out == test_obj_out
    assert obj_out.email == s.email
    assert obj_out.full_name == s.full_name
    assert obj_out.password == s.password
    assert obj_out.is_active == s.is_active
    assert obj_out.is_superuser == s.is_superuser


def test_upsert_delete(user_repo: UserRepo):
    # upsert
    s = UserSchemaUpsert(email=EmailStr("test_upsert_delete@mail.com"), password="pass")
    obj_out = user_repo.upsert(jsonable_encoder(s))
    test_obj_out = user_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert s.email == obj_out.email

    # delete
    assert user_repo.delete(obj_out.id) == 1
