#  Copyright (c) 2022. Alexandr Moroz

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from lib.L2_app.extra.config import settings

engine = create_engine(settings.SQLALCHEMY_DATABASE_URI, pool_pre_ping=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
