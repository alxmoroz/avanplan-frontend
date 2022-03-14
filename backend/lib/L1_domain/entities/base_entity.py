#  Copyright (c) 2022. Alexandr Moroz

from dataclasses import dataclass


@dataclass
class Persistable:
    id: int | None = None


@dataclass
class Titleable(Persistable):
    title: str | None = None


@dataclass
class Orderable(Titleable):
    order: int | None = None


@dataclass
class Statusable(Titleable):
    closed: bool | None = None


@dataclass
class Emailable:
    email: str | None = None
