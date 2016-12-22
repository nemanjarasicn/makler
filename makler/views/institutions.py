# -*- coding: utf-8 -*-
import transaction
import logging

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..models import Institution
from ..models import Instrument
from ..models import InstrumentType
from ..models import LabInformationSystem
from ..models import Supplier, log_info
from ..models import Contract

log = logging.getLogger(__name__)


@view_config(route_name='institution_new',
             renderer='institution_new.mak',
             request_method='GET')
def institution_new(request):
    """Displays form for creating new institution"""

    institution = Institution()

    return {
        'institution': institution
    }


@view_config(route_name='institution',
             renderer='institution_edit.mak',
             request_method='GET')
def institution_edit(request):
    """Displays form for editing existing institution"""

    id = request.matchdict['id']
    institution = (request.dbsession.query(Institution)
                   .filter(Institution.id == id)
                   .first())

    if not institution:
        raise HTTPNotFound

    instruments_query = (
        request.dbsession.query(Instrument)
        .join(Instrument.instrument_type)
        .filter(Instrument.institution_id == id)
        .order_by(Instrument.department, InstrumentType.manufacturer,
                  InstrumentType.name)
    )

    days_remain = int(request.registry.settings.get('days_remain', 30))

    instrument_types = (
        request.dbsession.query(InstrumentType)
        .order_by(InstrumentType.name)
    )

    lis_list = request.dbsession.query(LabInformationSystem)

    contracts = (
        request.dbsession.query(Contract)
        .filter(Contract.institution_id == id)
    )

    supplier_list = request.dbsession.query(Supplier)

    return {
        'institution': institution,
        'instruments': instruments_query.all(),
        'instrument_types': instrument_types.all(),
        'lis': lis_list.all(),
        'contracts': contracts.all(),
        'days_remain': days_remain,
        'suppliers': supplier_list
    }


@view_config(route_name='institution_new',
             request_method='POST')
def institution_create(request):
    """Creates an institution.
    """
    data = dict(request.params)
    safe_keys = ['city', 'address', 'name', 'contact_person', 'telephone']
    safe_data = {}

    for key in data.keys():
        if key in safe_keys:
            safe_data[key] = data[key]
    try:
        institution = Institution(**safe_data)
        request.dbsession.add(institution)
        request.dbsession.flush()
        id = institution.id
        transaction.commit()
        log_info(log, 'has made the new institution with ID: ',
                 id, request.authenticated_userid)
    except Exception:
        log.error('failed to make new institution')

        raise HTTPInternalServerError
    return HTTPFound(
        location=request.route_path('institution', id=id))


@view_config(route_name='institution',
             request_method='POST')
def institution_update(request):
    """Updates institutions"""

    id = request.POST['id']
    institution = (request.dbsession.query(Institution)
                   .filter(Institution.id == id)
                   .first())

    if not institution:
        raise HTTPNotFound

    institution.name = request.POST['name']
    institution.address = request.POST['address']
    institution.city = request.POST['city']
    institution.phone = request.POST['phone']

    try:
        transaction.commit()
        log_info(log, 'has edit institution with ID: ',
                 id, request.authenticated_userid)
    except Exception:
        log.error('failed to edit institution')
        raise HTTPInternalServerError
    return HTTPFound(location=request.route_path('institution', id=id))
