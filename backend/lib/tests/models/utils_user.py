#  Copyright (c) 2022. Alexandr Moroz

import random
import string
from contextlib import contextmanager
from typing import Generator

from lib.L1_domain.entities.users import User
from lib.L3_data.repositories import security_repo, user_repo


def _random_lower_string() -> str:
    return "".join(random.choices(string.ascii_lowercase, k=8))


def random_email() -> str:
    return f"{_random_lower_string()}@{_random_lower_string()}.com"


@contextmanager
def tmp_user(*, password: str | None = None, is_active: bool = True) -> Generator:
    user: User | None = None
    try:
        user = user_repo.create(
            User(
                email=random_email(),
                password=security_repo.secure_password(password or _random_lower_string()),
                is_active=is_active,
            )
        )
        yield user
    finally:
        user_repo.delete(user)
