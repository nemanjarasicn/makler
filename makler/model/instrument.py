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

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    type = Column("type", types.String(50))
    manufacturer = Column("manufacturer", types.String(50))
    name = Column("name", types.String(10))


class Instrument(Base):

    __tablename__ = 'instruments'

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    name = Column("name", types.String(50))
    active = Column("active", types.Boolean)
    installed = Column("installed", types.DateTime)
    institution_id = Column("institution_id",
                            types.Integer,
                            ForeignKey('institutions.id'),
                            nullable=False)
    instrument_type_id = Column(
        "instrument_type_id",
        types.Integer,
        ForeignKey('instrument_types.id')
    )
    description = Column("description", types.Text)

    instrument_type = relationship(InstrumentType, uselist=False)
    institution = relationship(Institution, backref="instruments", uselist=False)
