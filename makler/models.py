# -*- coding: utf-8 -*-
import hashlib

from sqlalchemy import types
from sqlalchemy.orm import relationship
from sqlalchemy.orm import backref
from sqlalchemy.orm import synonym
from sqlalchemy.schema import Column, ForeignKey
from sqlalchemy.schema import UniqueConstraint
from sqlalchemy.sql import func
from sqlalchemy.ext.declarative import declarative_base
import formencode
from formencode import validators


Base = declarative_base()
meta = Base.metadata

# This function use for log info


def log_info(log, message, user_login):
    d = {'user': user_login}
    return log.info(message, extra=d)


class Institution(Base):

    __tablename__ = 'institutions'
    __table_args__ = (
        UniqueConstraint('name', 'city',
                         name="institution_true_pk"),
        {}
    )

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    name = Column("name", types.String(100))
    city = Column("city", types.String(50))
    address = Column("address", types.String(80))
    phone = Column("phone", types.String(20))
    institution_type = Column("type", types.String(50))
    pib = Column("pib", types.Integer)
    account = Column("account", types.String(50))

    lis_id = Column("lis_id", types.Integer,
                    ForeignKey('lis.id'), nullable=True)

    lis = relationship('LabInformationSystem', backref='institution')

    # backrefs:
    #   contacts -- Contact[]

    contacts = relationship('Contact', backref='institution')

    contracts = relationship('Contract', backref='institution')


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
    name = Column("name", types.String(50))

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
    age = Column("age", types.String(50))
    sample_numbers = Column("sample_numbers", types.String(100))
    department = Column("department", types.String(100))

    instrument_type = relationship(
        InstrumentType,
        backref=backref("instruments", order_by="Instrument.name"))

    institution = relationship(
        Institution, backref="instruments")


class LabInformationSystem(Base):

    __tablename__ = 'lis'

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    name = Column("name", types.String(50))

    # backref: institution (Institution)


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

    # backref: institution (Institution)


class Contract(Base):

    __tablename__ = 'contracts'

    id = Column(types.Integer, nullable=False, primary_key=True)
    institution_id = Column(types.Integer,
                            ForeignKey('institutions.id'),
                            nullable=False)
    name = Column(types.String(250))
    announced = Column(types.DateTime)
    created = Column(types.DateTime)
    valid_until = Column(types.DateTime)
    description = Column(types.String(250))
    value = Column(types.Numeric)
    supplier_id = Column(types.Integer,
                         ForeignKey('suppliers.id'), nullable=True)

    # backrefs:
    #   institution (Institution)

    supplier = relationship('Supplier', backref='contracts')
    documents = relationship('Document', backref='contract')


class Document(Base):

    __tablename__ = 'documents'

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    contract_id = Column(types.Integer,
                         ForeignKey('contracts.id'),
                         nullable=False)
    original_name = Column("original_name", types.String(250))
    code_name = Column("code_name", types.String(50))
    upload_date = Column("upload_date", types.DateTime(timezone=True),
                         server_default=func.now())
    # backref: contract (Contract)


class Supplier(Base):

    __tablename__ = 'suppliers'

    id = Column("id", types.Integer, nullable=False, primary_key=True)
    name = Column("name", types.String(50))

    # backref: contracts (Contract)


class UserValidator(formencode.Schema):

    # Use for validation of user
    ignore_key_missing = True
    id = validators.Int(if_missing=None)
    username = formencode.All(validators.UnicodeString(
            not_empty=True), validators.Regex(regex='[a-zA-Z0-9]+'))
    first_name = validators.Regex(not_empty=True, regex='[a-zA-Z\s]+')
    last_name = validators.Regex(not_empty=True, regex='[a-zA-Z\s]+')
    password = validators.Regex(if_empty='', regex='.{4,}')
    confipass = validators.ByteString(if_empty='')
    email = validators.Email(if_missing=None)
    admin = validators.Bool(if_missing=False)
    chained_validators = [validators.FieldsMatch('password', 'confipass')]


class User(Base):

    __tablename__ = 'users'
    __table_args__ = (
        UniqueConstraint('username',
                         name="users_true_pk"),
        {}
    )

    id = Column(types.Integer, nullable=False, primary_key=True)
    username = Column(types.String(50))
    first_name = Column(types.String(50))
    last_name = Column(types.String(50))
    _password = Column("password", types.Unicode(80), nullable=False)
    email = Column(types.String(50))
    admin = Column(types.Boolean)

    def _get_password(self):
        """Return hashed password.
        """
        return self._password

    def _set_password(self, password):
        """Set password and hash on the fly.
        """
        self._password = hashlib.sha1(password).hexdigest()[:80]

    password = synonym('_password', descriptor=property(_get_password,
                                                        _set_password))

    def validate_password(self, password):
        """Validate user password.

        :return: If password is correct.
        """
        return self._password == hashlib.sha1(password).hexdigest()
