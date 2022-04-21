#  Copyright (c) 2022. Alexandr Moroz

from typing import Generator

import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from lib.L2_data.db import DBSession
from lib.L3_app.main import app


@pytest.fixture(scope="session")
def client() -> Generator:
    with TestClient(app) as c:
        yield c


@pytest.fixture(scope="session")
def db() -> Session:
    session = DBSession()
    yield session
    session.close()
