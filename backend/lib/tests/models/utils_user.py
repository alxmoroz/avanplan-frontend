#  Copyright (c) 2022. Alexandr Moroz

import random
import string
from contextlib import contextmanager
from typing import Generator

from lib.L1_domain.entities.users import User
from lib.L2_data.repositories import SecurityRepo, UserRepo


def _random_lower_string() -> str:
    return "".join(random.choices(string.ascii_lowercase, k=8))


def random_email() -> str:
    return f"{_random_lower_string()}@{_random_lower_string()}.com"


# TODO: не нравится почему-то, что сюда параметром юзеррепо идет
@contextmanager
def tmp_user(
    user_repo: UserRepo,
    *,
    password: str | None = None,
    is_active: bool = True,
) -> Generator:
    user: User | None = None
    try:
        user = user_repo.create(
            User(
                email=random_email(),
                password=SecurityRepo.secure_password(password or _random_lower_string()),
                is_active=is_active,
            )
        )
        yield user
    finally:
        user_repo.delete(user)
