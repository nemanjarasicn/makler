# -*- coding: utf-8 -*-

import hashlib

from sqlalchemy import types
from sqlalchemy.schema import Column
from sqlalchemy.schema import UniqueConstraint
from sqlalchemy.orm import synonym

from .base import Base


class User(Base):

    __tablename__ = 'users'
    __table_args__ = (
        UniqueConstraint('username',
                         name="users_true_pk"),
        {}
    )

    id = Column(types.Integer, nullable=False, primary_key=True)
    username = Column(types.String(50))
    name = Column(types.String(50))
    _password = Column("password", types.Unicode(80), nullable=False)

    def _get_password(self):
        """Return hashed password.
        """
        return self._password

    def _set_password(self, password):
        """Set password and hash on the fly.
        """
        self._password = hashlib.sha1(password).hexdigest()

    password = synonym('_password', descriptor=property(_get_password,
                                                        _set_password))

    def validate_password(self, password):
        """Validate user password.

        :return: If password is correct.
        """
        return self._password == hashlib.sha1(password).hexdigest()
