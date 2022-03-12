#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass
from datetime import datetime


@dataclass
class Identifiable:
    id: int | None = None


@dataclass
class Timestampable:
    created_on: datetime | None = None
    updated_on: datetime | None = None


@dataclass
class Titleable:
    title: str | None = None


@dataclass
class Orderable:
    order: int | None = None


@dataclass
class Importable:
    remote_code: str | None = None


@dataclass
class Statusable:
    closed: bool | None = None
