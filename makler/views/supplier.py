# -*- coding: utf-8 -*-

from pyramid.view import view_config

from ..models import Supplier
from ..models import Contract
from ..models import Institution

from sqlalchemy import func, desc
import datetime


@view_config(route_name='supplier',
             renderer='supplier.mak',
             request_method='GET')
def supplier(request):
    """Return a list of suppliers with number of active contracts and their total value."""
    today = datetime.datetime.now()

    suppliers = (
        request.dbsession.query
        (Supplier, func.count(Contract.id), func.sum(Contract.value))
        .join('contracts')
        .filter(Contract.valid_until > today)
        .group_by(Supplier.id)
        .order_by(
            desc(func.count(Contract.id)), desc(func.sum(Contract.value)))
    )

    return {
        'suppliers': suppliers,
    }


@view_config(route_name='supplier_form',
             renderer='supplier_form.mak',
             request_method='GET')
def supplier_form(request):
    """Return active contracts from supplier.

    Request params:
    :param id: supplier id
    """
    id = request.matchdict['id']
    today = datetime.datetime.now()

    contracts = (
        request.dbsession.query(Supplier.name, Contract.name, Contract.value, Institution.name)
        .join(Contract).join(Institution)
        .filter(Supplier.id == id).filter(Contract.valid_until > today)
        .order_by(Institution.name)
        .all()
    )

    return {
        'contracts': contracts,
    }
