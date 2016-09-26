# -*- coding: utf-8 -*-
import transaction

import logging
import datetime
import decimal

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..models import Contract

log = logging.getLogger(__name__)


@view_config(request_method='GET')
def get_data(request):

    data = dict(request.params)
    data['institution_id'] = data.get('institution_id')

    try:
        data['announced'] = (
            datetime.datetime.strptime(
                data.get('announced'), "%d.%m.%Y")
        )
        data['created'] = (
            datetime.datetime.strptime(
                data.get('created'), "%d.%m.%Y")
        )
        data['valid_until'] = (
            datetime.datetime.strptime(
                data.get('valid_until'), "%d.%m.%Y")
        )
        data['value'] = (
            decimal.Decimal(data['value'])
        )

    except (KeyError, ValueError):
        return HTTPFound(location=request.route_path(
            'institution', id=data['institution_id']))

    return data


@view_config(route_name='contract_new',
             request_method="POST")
def contract_new(request):

    data = get_data(request)

    try:
        contract = Contract(**data)
        request.dbsession.add(contract)
        transaction.commit()
    except Exception as e:
        log.error(e)
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path(
        'institution', id=data['institution_id']))


@view_config(route_name='contract_edit',
             request_method='POST')
def contract_edit(request):
    """Updates contracts"""

    data = get_data(request)

    id = request.POST['id']
    contract = (request.dbsession.query(Contract)
                .filter(Contract.id == id)
                .first())

    if not contract:
        raise HTTPNotFound

    contract.name = data.get('name')
    contract.description = data.get('description')
    contract.value = data.get('value')
    contract.announced = data.get('announced')
    contract.created = data.get('created')
    contract.valid_until = data.get('valid_until')
    contract.supplier_id = data.get('supplier_id')

    try:
        transaction.commit()
    except Exception as e:
        log.error(e)
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path(
        'institution', id=data['institution_id']))
