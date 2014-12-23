# -*- coding: utf-8 -*-

from sqlalchemy import types
from sqlalchemy.schema import Column

from sqlalchemy.orm import relationship

from .base import Base
from .institution import Institution


class LabInformationSystem(Base):

    __tablename__ = 'lis'

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    name = Column("name", types.String(50))

    institution = relationship(Institution, backref="lis", uselist=False)
