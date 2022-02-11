#  Copyright (c) 2022. Alexandr Moroz

import random
import string
from contextlib import contextmanager
from typing import Generator

from lib.L1_domain.entities.users import User
from lib.L3_data.repositories import user_repo


def _random_lower_string() -> str:
    return "".join(random.choices(string.ascii_lowercase, k=8))


def random_email() -> str:
    return f"{_random_lower_string()}@{_random_lower_string()}.com"


@contextmanager
def random_user(password: str | None = None) -> Generator:
    user = None
    try:
        password = password or _random_lower_string()
        user = user_repo.create(User(email=random_email(), password=password))
        yield user
    finally:
        user_repo.delete(user)
