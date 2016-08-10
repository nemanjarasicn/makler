# -*- coding: utf-8 -*-

from sqlalchemy import types
from sqlalchemy.orm import relationship
from sqlalchemy.schema import Column
from sqlalchemy.schema import ForeignKey

from .base import Base
from .institution import Institution


class Contract(Base):

    __tablename__ = 'contracts'

    id = Column(types.Integer, nullable=False, primary_key=True)
    institution_id = Column(types.Integer,
                            ForeignKey('institutions.id'),
                            nullable=False)
    name = Column(types.String(50))
    announced = Column(types.DateTime(timezone=True))
    created = Column(types.DateTime(timezone=True))
    valid_until = Column(types.DateTime(timezone=True))
    description = Column(types.String(50))
    value = Column(types.Numeric)
    supplier_id = Column(types.Integer,
                         ForeignKey('suppliers.id'), nullable=True)
    institution = relationship(Institution, backref="contracts", uselist=False)
