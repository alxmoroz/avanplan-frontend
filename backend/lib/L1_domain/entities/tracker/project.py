#  Copyright (c) 2022. Alexandr Moroz

from .base_tracker import ImportableEntity

# from .task import Task
# from .version import Version


class Project(ImportableEntity):

    # projects: list[Project] | None
    # tasks: list[Task] | None
    # versions: list[Version] | None
    class Config:
        orm_mode = True
