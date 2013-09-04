# -*- coding: utf-8 -*-

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


@view_config(route_name='instrument_type_new',
             renderer='instrument_type_new.mak',
             request_method='GET')
def instrument_type_new(request):
    instrument_type = InstrumentType()
    print request.referer

    return {
        'instrument_type': instrument_type,
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
        'name',
        'active',
        'type',
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
        Session.flush()
        Session.commit()
    except:
        raise HTTPInternalServerError
        Session.rollback()

    message = "Uspešno ste dodali aparat."
    request.session.flash(message)

    return HTTPFound(location=request.route_path('home'))


@view_config(route_name='instrument',
             request_method="POST")
def instrument_update(request):
    id = request.matchdict['id']

    instrument = (Session.query(Instrument)
                  .filter(Instrument.id == id)
                  .first())

    if not instrument:
        raise HTTPNotFound

    instrument.name = request.POST['name']
    instrument.description = request.POST['description']
    instrument.active = request.POST['active']

    try:
        Session.flush()
        Session.commit()
    except:
        Session.rollback()

    return HTTPFound(location=request.route_path('instrument', id=id))


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

    try:
        Session.add(instrument_type)
        Session.flush()
        Session.commit()
    except:
        Session.rollback()

    message = "Uspešno ste dodali model aparata."
    request.session.flash(message)
    print request.referer

    return HTTPFound(location=request.route_path('home'))
