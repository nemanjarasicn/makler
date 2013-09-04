# -*- coding: utf-8 -*-

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..model.instrument import InstrumentType
from ..model.session import Session


@view_config(route_name='instrument_type_new',
             renderer='instrument_type_new.mak',
             request_method='GET')
def instrument_type_new(request):
    """Display a form for creating instrument type.
    """
    instrument_type = InstrumentType()

    return {
        'instrument_type': instrument_type,
    }


@view_config(route_name='instrument_type',
             renderer='instrument_type_edit.mak',
             request_method='GET')
def instrument_type_edit(request):
    """Display a form for editing instrument type.
    """
    id = request.matchdict['id']

    instrument_type = (Session.query(InstrumentType)
                       .filter(InstrumentType.id == id)
                       .first())

    if not instrument_type:
        raise HTTPNotFound

    return {
        'instrument_type': instrument_type,
    }


@view_config(route_name='instrument_type_new',
             request_method="POST")
def instrument_type_create(request):
    data = dict(request.params)
    safe_keys = [
        'manufacturer',
        'name',
        'type']
    safe_data = {}

    for key in data.keys():
        if key in safe_keys:
            safe_data[key] = data[key]

    instrument_type = InstrumentType(**safe_data)

    print instrument_type.manufacturer

    try:
        Session.add(instrument_type)
        Session.flush()
        Session.commit()
    except:
        Session.rollback()

    return HTTPFound(location=request.route_path('home'))


@view_config(route_name='instrument_type',
             request_method="POST")
def instrument_type_update(request):
    id = request.matchdict['id']

    instrument_type = (Session.query(InstrumentType)
                       .filter(InstrumentType.id == id)
                       .first())

    if not instrument_type:
        raise HTTPNotFound

    print request.POST

    if 'name' in request.POST and request.POST['name']:
        instrument_type.name = request.POST['name']
    if 'type' in request.POST and request.POST['type']:
        instrument_type.type = request.POST['type']
    if 'manufacturer' in request.POST and request.POST['manufacturer']:
        instrument_type.manufacturer = request.POST['manufacturer']
        print request.POST['manufacturer']
        print instrument_type.manufacturer

    try:
        Session.flush()
        Session.commit()
    except:
        Session.rollback()
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path('home'))
