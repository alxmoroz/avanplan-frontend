#  Copyright (c) 2022. Alexandr Moroz

from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session

from lib.L1_domain.entities.auth.user import CreateUser, UpdateUser
from lib.L2_app.extra.security import verify_password
from lib.L3_data.repositories import user_repo
from lib.tests.utils.user import random_email, random_lower_string


def test_create_user(db: Session) -> None:
    email = random_email()
    password = random_lower_string()
    user_in = CreateUser(email=email, password=password)
    user = user_repo.user_repo.create(db, obj_in=user_in)
    assert user.email == email
    assert hasattr(user, "hashed_password")
    user_repo.user_repo.delete(db, p_id=user.id)


def test_authenticate_user(db: Session) -> None:
    email = random_email()
    password = random_lower_string()
    user_in = CreateUser(email=email, password=password)
    user = user_repo.user_repo.create(db, obj_in=user_in)
    authenticated_user = user_repo.user_repo.authenticate(
        db, email=email, password=password
    )
    assert authenticated_user
    assert user.email == authenticated_user.email
    user_repo.user_repo.delete(db, p_id=user.id)


def test_not_authenticate_user(db: Session) -> None:
    email = random_email()
    password = random_lower_string()
    user = user_repo.authenticate(db, email=email, password=password)
    assert user is None


def test_check_user_active(db: Session) -> None:
    email = random_email()
    password = random_lower_string()
    user_in = UpdateUser(email=email, password=password)
    user = user_repo.create(db, obj_in=user_in)
    assert user.is_active
    user_repo.delete(db, p_id=user.id)


def test_check_user_inactive(db: Session) -> None:
    email = random_email()
    password = random_lower_string()
    user_in = CreateUser(email=email, password=password, is_active=False)
    user = user_repo.create(db, obj_in=user_in)
    assert user.is_active is False
    user_repo.delete(db, p_id=user.id)


def test_check_if_user_is_superuser(db: Session) -> None:
    email = random_email()
    password = random_lower_string()
    user_in = CreateUser(email=email, password=password, is_superuser=True)
    user = user_repo.create(db, obj_in=user_in)
    assert user.is_superuser is True
    user_repo.delete(db, p_id=user.id)


def test_check_if_user_is_superuser_normal_user(db: Session) -> None:
    username = random_email()
    password = random_lower_string()
    user_in = CreateUser(email=username, password=password)
    user = user_repo.create(db, obj_in=user_in)
    assert user.is_superuser is False
    user_repo.delete(db, p_id=user.id)


def test_get_user(db: Session) -> None:
    password = random_lower_string()
    username = random_email()
    user_in = CreateUser(email=username, password=password, is_superuser=True)
    user = user_repo.create(db, obj_in=user_in)
    user_2 = user_repo.get(db, p_id=user.id)
    assert user_2
    assert user.email == user_2.email
    assert jsonable_encoder(user) == jsonable_encoder(user_2)
    user_repo.delete(db, p_id=user.id)


def test_update_user(db: Session) -> None:
    password = random_lower_string()
    email = random_email()
    user_in = CreateUser(email=email, password=password, is_superuser=True)
    user = user_repo.create(db, obj_in=user_in)
    new_password = random_lower_string()
    user_in_update = UpdateUser(password=new_password, is_superuser=True)
    user_repo.update(db, db_obj=user, obj_in=user_in_update)
    user_2 = user_repo.get(db, p_id=user.id)
    assert user_2
    assert user.email == user_2.email
    assert verify_password(new_password, user_2.hashed_password)
    user_repo.delete(db, p_id=user.id)
