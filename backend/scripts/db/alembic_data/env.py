#  Copyright (c) 2022. Alexandr Moroz


from lib.L2_data.models.base_model import BaseModel  # noqa
from lib.L2_data.models import *  # noqa
from scripts.db.alemb_base import alembic_run

alembic_run(BaseModel.metadata)
