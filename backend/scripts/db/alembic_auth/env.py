#  Copyright (c) 2022. Alexandr Moroz

from scripts.db.alemb_base import alembic_run

from lib.L2_data.models_auth.base_model import BaseAuthModel  # noqa
from lib.L2_data.models_auth import *  # noqa

alembic_run(BaseAuthModel.metadata)
