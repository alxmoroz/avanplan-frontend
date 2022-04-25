#  Copyright (c) 2022. Alexandr Moroz

from typing import Generator

import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from lib.L2_data.db import session_maker_for_org
from lib.L3_app.main import app


@pytest.fixture(scope="session")
def client() -> Generator:
    with TestClient(app) as c:
        yield c


@pytest.fixture(scope="session")
def db() -> Session:
    session = session_maker_for_org("test")()
    yield session
    session.close()


@pytest.fixture(scope="session")
def db_auth() -> Session:
    session = session_maker_for_org("auth")()
    yield session
    session.close()
