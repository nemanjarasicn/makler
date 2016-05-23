# -*- coding: utf-8 -*-
import transaction

import datetime

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.httpexceptions import HTTPBadRequest
from pyramid.httpexceptions import HTTPInternalServerError

from ..model.contract import Contract
from ..model.session import Session


@view_config(route_name='contract_new',
             request_method="POST")
def contract_new(request):
    data = dict(request.params)
    institution_id = data.get('institution_id')
    try:
        data['time_created'] = (
            datetime.datetime.strptime(
                data.get('time_created'), "%d.%m.%Y").date()
        )
        data['time_updated'] = (
            datetime.datetime.strptime(
                data.get('time_updated'), "%d.%m.%Y").date()
        )
        data['valid_until'] = (
            datetime.datetime.strptime(
                data.get('valid_until'), "%d.%m.%Y").date()
        )

    except (KeyError, ValueError):
        return HTTPBadRequest('Datum nije u odgovarajucem formatu')

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
        data['time_created'] = (
            datetime.datetime.strptime(
                data.get('time_created'), "%d.%m.%Y").date()
        )
        data['time_updated'] = (
            datetime.datetime.strptime(
                data.get('time_updated'), "%d.%m.%Y").date()
        )
        data['valid_until'] = (
            datetime.datetime.strptime(
                data.get('valid_until'), "%d.%m.%Y").date()
        )

    except (KeyError, ValueError):
        return HTTPBadRequest('Datum nije u odgovarajucem formatu')

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
    contract.time_created = data['time_created']
    contract.time_updated = data['time_updated']
    contract.valid_until = data['valid_until']

    try:
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path(
        'institution', id=institution_id))
