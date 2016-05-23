# -*- coding: utf-8 -*-

from sqlalchemy import types
from sqlalchemy.orm import relationship
from sqlalchemy.schema import Column
from sqlalchemy.schema import ForeignKey

from .base import Base
from .contract import Contract
from sqlalchemy.sql import func


class Document(Base):

    __tablename__ = 'documents'

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    contract_id = Column(types.Integer,
                         ForeignKey('contracts.id'),
                         nullable=False)
    original_name = Column("original_name", types.String(50))
    code_name = Column("code_name", types.String(50))
    upload_date = Column("upload_date", types.DateTime(timezone=True),
                         server_default=func.now())
    contract = relationship(Contract, backref="documents", uselist=False)
