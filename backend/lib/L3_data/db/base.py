# Import all the models, so that Base has them before being
# imported by Alembic
from lib.L3_data.models.base_class import Base  # noqa

from ..models.user import User  # noqa
