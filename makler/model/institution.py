# -*- coding: utf-8 -*-

from sqlalchemy import types
from sqlalchemy.schema import Column, ForeignKey
from sqlalchemy.schema import UniqueConstraint
from sqlalchemy.orm import relationship

from .base import Base


class Institution(Base):

    __tablename__ = 'institutions'
    __table_args__ = (
        UniqueConstraint('name', 'city',
                         name="institution_true_pk"),
        {}
    )

    id = Column(types.Integer, primary_key=True)
    name = Column(types.String(50))
    city = Column(types.String(50))
    address = Column(types.String(50))
    contact_person = Column(types.String(50))
    telephone = Column(types.String(15))


