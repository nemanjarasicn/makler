# -*- coding: utf-8 -*-

from sqlalchemy import types
from sqlalchemy.schema import Column
from sqlalchemy.schema import UniqueConstraint

from .base import Base


class Institution(Base):

    __tablename__ = 'institutions'
    __table_args__ = (
        UniqueConstraint('name', 'city',
                         name="institution_true_pk"),
        {}
    )

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    name = Column("name", types.String(50))
    city = Column("city", types.String(50))
    address = Column("address", types.String(50))
    phone = Column("phone", types.String(15))
