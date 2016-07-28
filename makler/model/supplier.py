# -*- coding: utf-8 -*-

from sqlalchemy import types
from sqlalchemy.schema import Column

from sqlalchemy.orm import relationship

from .base import Base
from .contract import Contract


class Supplier(Base):

    __tablename__ = 'suppliers'

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    name = Column("name", types.String(50))

    contract = relationship(Contract, backref="suppliers", uselist=False)
