# -*- coding: utf-8 -*-
import transaction

import datetime

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..model.contract import Contract
from ..model.session import Session


@view_config(route_name='contract_new',
             request_method="POST")
def contract_new(request):
    data = dict(request.params)
    institution_id = data.get('institution_id')
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

    except (KeyError, ValueError):
        return HTTPFound(location=request.route_path(
                         'institution', id=institution_id))

    contract = Contract(**data)
    Session.add(contract)
    Session.flush()

    try:
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path(
        'institution', id=institution_id))


@view_config(route_name='contract_edit',
             request_method='POST')
def contract_edit(request):
    """Updates contracts"""

    data = dict(request.params)
    institution_id = data.get('institution_id')

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

    except (KeyError, ValueError):
        return HTTPFound(location=request.route_path(
                         'institution', id=institution_id))

    contract = Contract(**data)

    id = request.POST['id']
    contract = (Session.query(Contract)
                .filter(Contract.id == id)
                .first())

    if not contract:
        raise HTTPNotFound

    contract.name = request.POST['name']
    contract.description = request.POST['description']
    contract.value = request.POST['value']
    contract.announced = data['announced']
    contract.created = data['created']
    contract.valid_until = data['valid_until']

    try:
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path(
        'institution', id=institution_id))
