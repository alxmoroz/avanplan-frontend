#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import column

from lib.L2_data.repositories import SecurityRepo
from lib.tests.conf_user import tmp_object


def test_get_obj(user_repo):
    with tmp_object(user_repo) as obj:
        obj_out = user_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_get_objects(user_repo):
    with tmp_object(user_repo) as o1, tmp_object(user_repo) as o2:
        objects = user_repo.get(
            limit=2,
            where=column("id").in_([o1.id, o2.id]),
        )
        assert o1 in objects
        assert o2 in objects
        assert len(objects) == 2


def test_create_object(user_repo):

    password = "password"
    with tmp_object(user_repo, password=password) as obj:
        obj_out = user_repo.get_one(id=obj.id)
        assert obj == obj_out
        assert obj.password != password
        assert SecurityRepo.verify_password(password, obj.password)


def test_update_object(user_repo):
    with tmp_object(user_repo) as obj_in:
        new_full_name = "full_name"
        obj_in.full_name = new_full_name
        assert user_repo.update(obj_in) == 1

        obj_out = user_repo.get_one(id=obj_in.id)
        assert obj_in == obj_out
        assert obj_out.full_name == new_full_name


def test_delete_object(user_repo):
    with tmp_object(user_repo) as obj:
        assert user_repo.delete(obj) == 1
