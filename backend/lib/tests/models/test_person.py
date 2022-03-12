#  Copyright (c) 2022. Alexandr Moroz

from datetime import datetime

from fastapi.encoders import jsonable_encoder
from sqlalchemy import column

from lib.L2_data.repositories.db import PersonRepo
from lib.L2_data.schema import PersonSchemaCreate


def test_get_one(person_repo: PersonRepo, tmp_person):
    obj_out = person_repo.get_one(id=tmp_person.id)
    assert tmp_person == obj_out


def test_get_create(person_repo: PersonRepo, tmp_person):
    s = PersonSchemaCreate(firstname="2")
    obj2 = person_repo.create(jsonable_encoder(s))

    objects = person_repo.get(
        limit=2,
        where=column("id").in_([tmp_person.id, obj2.id]),
    )
    assert tmp_person in objects
    assert obj2 in objects
    assert len(objects) == 2

    assert person_repo.delete(obj2.id) == 1


def test_update(person_repo: PersonRepo, tmp_person):

    s = PersonSchemaCreate(
        id=tmp_person.id,
        firstname="firstname",
        lastname="lastname",
        remote_code="remote_code",
        updated_on=datetime.now(),
    )

    obj_out = person_repo.update(jsonable_encoder(s))
    test_obj_out = person_repo.get_one(id=tmp_person.id)

    assert obj_out == test_obj_out
    assert obj_out.firstname == s.firstname
    assert obj_out.lastname == s.lastname
    assert obj_out.remote_code == s.remote_code
    assert obj_out.updated_on == s.updated_on


def test_upsert_delete(person_repo: PersonRepo):
    # upsert
    s = PersonSchemaCreate(firstname="test_upsert_delete")
    obj_out = person_repo.update(jsonable_encoder(s))
    test_obj_out = person_repo.get_one(id=obj_out.id)

    assert obj_out == test_obj_out
    assert s.firstname == obj_out.firstname

    # delete
    assert person_repo.delete(obj_out.id) == 1
