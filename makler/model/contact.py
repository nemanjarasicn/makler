# -*- coding: utf-8 -*-

from sqlalchemy import types
from sqlalchemy.orm import relationship
from sqlalchemy.schema import Column
from sqlalchemy.schema import UniqueConstraint
from sqlalchemy.schema import ForeignKey

from .base import Base
from .institution import Institution


class Contact(Base):

    __tablename__ = 'contacts'
    __table_args__ = (
        UniqueConstraint('institution_id', 'name', 'telephone',
                         name="contacts_true_pk"),
        {}
    )

    id = Column(types.Integer, nullable=False, primary_key=True)
    institution_id = Column(types.Integer,
                            ForeignKey('institutions.id'),
                            nullable=False)
    name = Column(types.String(50))
    telephone = Column(types.String(50))

    institution = relationship(Institution, backref="contacts", uselist=False)
