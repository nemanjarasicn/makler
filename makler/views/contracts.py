# -*- coding: utf-8 -*-
import transaction

import datetime
from datetime import date

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.httpexceptions import HTTPBadRequest
from pyramid.httpexceptions import HTTPInternalServerError

from ..model.contract import Contract
from ..model.session import Session


@view_config(route_name='contract_delete',
             request_method='POST')
def contract_delete(request):

    id = request.POST['id']
    contract = Session.query(Contract).filter(Contract.id == id).first()

    if not contract:
        raise HTTPNotFound

    institution_id = contract.institution.id
    try:
        Session.delete(contract)
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(
        location=request.route_path('institution', id=institution_id))


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
