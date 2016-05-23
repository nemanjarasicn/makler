# -*- coding: utf-8 -*-

from sqlalchemy import types
from sqlalchemy.orm import relationship
from sqlalchemy.schema import Column
from sqlalchemy.schema import ForeignKey

from .base import Base
from .institution import Institution
from sqlalchemy.sql import func


class Contract(Base):

    __tablename__ = 'contracts'

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    institution_id = Column(types.Integer,
                            ForeignKey('institutions.id'),
                            nullable=False)
    name = Column("name", types.String(50))
    time_created = Column("time_created", types.DateTime(timezone=True),
                          server_default=func.now())
    time_updated = Column("time_updated", types.DateTime(timezone=True),
                          onupdate=func.now())
    valid_until = Column("valid_until", types.DateTime(timezone=True),
                         server_default=func.now())
    description = Column("description", types.String(50))
    value = Column("value", types.String(50))
    institution = relationship(Institution, backref="contracts", uselist=False)
