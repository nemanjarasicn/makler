# -*- coding: utf-8 -*-
import transaction

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..model.instrument import Instrument
from ..model.instrument import InstrumentType
from ..model.institution import Institution
from ..model.session import Session


@view_config(route_name='instrument_new',
             renderer='instrument_new.mak',
             request_method='GET')
def instrument_new(request):
    """Display a form for creating instrument.
    """
    id = request.matchdict['id']

    institution = (Session.query(Institution)
                   .filter(Institution.id == id)
                   .first())

    instrument_types = Session.query(InstrumentType).all()

    if not institution:
        raise HTTPNotFound

    return {
        'institution': institution,
        'instrument_types': instrument_types
    }


@view_config(route_name='instrument',
             renderer='instrument_edit.mak',
             request_method='GET')
def instrument_edit(request):
    id = request.matchdict['id']
    instrument = (Session.query(Instrument)
                  .filter(Instrument.id == id)
                  .first())

    if not instrument:
        raise HTTPNotFound

    return {
        'instrument': instrument,
    }


@view_config(route_name='instrument_new',
             request_method='POST')
def instrument_create(request):
    data = dict(request.params)
    safe_keys = [
        'instrument_type_id',
        'institution_id',
        'active',
        'department',
        'age',
        'sample_numbers',
        'category_id',
        'description']
    safe_data = {}

    for key in data.keys():
        if key in safe_keys:
            safe_data[key] = data[key]

    instrument = Instrument(**safe_data)

    if not instrument.name:
        instrument_type = (
            Session.query(InstrumentType)
            .filter(InstrumentType.id == data['instrument_type_id'])
            .one())

        instrument.name = instrument_type.name

    try:
        Session.add(instrument)
        transaction.commit()
    except:
        raise
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path(
        'institution', id=data['institution_id']))


@view_config(route_name='instrument',
             request_method="POST")
def instrument_update(request):
    id = request.matchdict['id']

    instrument = (Session.query(Instrument)
                  .filter(Instrument.id == id)
                  .first())

    institution_id = instrument.institution.id

    if not instrument:
        raise HTTPNotFound

    if 'name' in request.POST:
        instrument.name = request.POST['name']

    if 'description' in request.POST:
        instrument.description = request.POST['description']

    if 'age' in request.POST:
        instrument.age = request.POST['age']

    if 'sample_numbers' in request.POST:
        instrument.sample_numbers = request.POST['sample_numbers']

    if 'department' in request.POST:
        instrument.department = request.POST['department']

    # TODO: Is there a better way to handle this?
    if 'active' in request.POST and request.POST['active']:
        instrument.active = True
    else:
        instrument.active = False

    try:
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path(
        'institution', id=institution_id))


@view_config(route_name='instrument_delete',
             request_method="POST")
def instrument_delete(request):
    id = request.POST['id']
    instrument = Session.query(Instrument).filter(Instrument.id == id).first()

    if not instrument:
        raise HTTPNotFound

    institution_id = instrument.institution.id
    try:
        Session.delete(instrument)
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path(
        'institution', id=institution_id))
