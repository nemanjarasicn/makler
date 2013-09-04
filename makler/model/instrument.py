# -*- coding: utf-8 -*-

from sqlalchemy import types
from sqlalchemy.schema import Column, ForeignKey
from sqlalchemy.schema import UniqueConstraint
from sqlalchemy.orm import relationship

from .base import Base
from .institution import Institution


class InstrumentType(Base):

    __tablename__ = 'instrument_types'
    __table_args__ = (
        UniqueConstraint('name', 'manufacturer',
                         name="instrument_type_true_pk"),
        {}
    )

    id = Column(types.Integer, nullable=False, primary_key=True)
    type = Column(types.String(50))
    manufacturer = Column(types.String(50))
    name = Column(types.String(10))


class Instrument(Base):

    __tablename__ = 'instruments'

    id = Column(types.Integer, nullable=False, primary_key=True)
    name = Column(types.String(50))
    active = Column(types.Boolean)
    institution_id = Column(types.Integer,
                            ForeignKey('institutions.id'),
                            nullable=False)
    instrument_type_id = Column(
        types.Integer,
        ForeignKey('instrument_types.id')
    )
    description = Column(types.Text)

    instrument_type = relationship(InstrumentType, uselist=False)
    institution = relationship(Institution, uselist=False)
