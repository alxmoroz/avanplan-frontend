#  Copyright (c) 2022. Alexandr Moroz

from contextlib import contextmanager
from datetime import datetime
from typing import Generator

import pytest
from sqlalchemy import column

from lib.L1_domain.entities.tracker import Person
from lib.L2_data.repositories import PersonRepo


def test_get_obj(person_repo):
    with tmp_object(person_repo) as obj:
        obj_out = person_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_get_objects(person_repo):
    with tmp_object(person_repo) as o1, tmp_object(person_repo) as o2:
        objects = person_repo.get(
            limit=2,
            where=column("id").in_([o1.id, o2.id]),
        )
        assert o1 in objects
        assert o2 in objects
        assert len(objects) == 2


def test_create_object(person_repo):
    with tmp_object(person_repo) as obj:
        obj_out = person_repo.get_one(id=obj.id)
        assert obj == obj_out


def test_update_object(person_repo):
    with tmp_object(person_repo) as obj_in:
        firstname = obj_in.firstname = "firstname"
        lastname = obj_in.lastname = "lastname"
        remote_code = obj_in.remote_code = "remote_code"
        imported_on = obj_in.imported_on = datetime.now()
        assert person_repo.update(obj_in) == 1

        obj_out = person_repo.get_one(id=obj_in.id)
        assert obj_in == obj_out
        assert obj_out.firstname == firstname
        assert obj_out.lastname == lastname
        assert obj_out.remote_code == remote_code
        assert obj_out.imported_on == imported_on


def test_delete_object(person_repo):
    with tmp_object(person_repo) as obj:
        assert person_repo.delete(obj) == 1


@pytest.fixture(scope="module")
def person_repo(db) -> PersonRepo:
    yield PersonRepo(db)


@contextmanager
def tmp_object(person_repo) -> Generator:
    person: Person | None = None
    try:
        person = person_repo.create(Person())
        yield person
    finally:
        person_repo.delete(person)
