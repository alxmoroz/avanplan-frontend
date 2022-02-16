#  Copyright (c) 2022. Alexandr Moroz


class ApiException(Exception):
    def __init__(self, code: int, detail: str | None):
        self.code = code
        self.detail = detail
