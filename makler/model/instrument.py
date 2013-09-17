# -*- coding: utf-8 -*-

from sqlalchemy import types
from sqlalchemy.schema import Column, ForeignKey
from sqlalchemy.schema import UniqueConstraint
from sqlalchemy.orm import relationship
from sqlalchemy.orm import backref

from .base import Base
from .institution import Institution


class InstrumentTypeCategory(Base):

    __tablename__ = 'instrument_type_categories'
    __table_args__ = (
        UniqueConstraint('name',
                         name="instrument_type_category_true_pk"),
        {}
    )

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    name = Column("name", types.String(50))

    # backrefs: instrument_types (InstrumentType)


class InstrumentType(Base):

    __tablename__ = 'instrument_types'
    __table_args__ = (
        UniqueConstraint('name', 'manufacturer',
                         name="instrument_type_true_pk"),
        {}
    )

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    category_id = Column("category_id", types.Integer,
                         ForeignKey('instrument_type_categories.id'))
    manufacturer = Column("manufacturer", types.String(50))
    name = Column("name", types.String(10))

    category = relationship(
        InstrumentTypeCategory, uselist=False,
        backref="instrument_types"
    )

    # backrefs: instruments (Instrument)


class Instrument(Base):

    __tablename__ = 'instruments'

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    name = Column("name", types.String(50))
    active = Column("active", types.Boolean)
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
    age = Column("age", types.Integer)
    sample_numbers = Column("sample_numbers", types.Integer)
    department = Column("department", types.String(50))

    instrument_type = relationship(
        InstrumentType,
        backref=backref("instruments", order_by="Instrument.name"))

    institution = relationship(
        Institution, backref="instruments")
