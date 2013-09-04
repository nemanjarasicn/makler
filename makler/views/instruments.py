# -*- coding: utf-8 -*-

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound

from ..model.instrument import Instrument
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

    if not institution:
        raise HTTPNotFound

    return {
        'institution': institution,
    }


@view_config(route_name='instrument_type_new',
             renderer='instrument_type_new.mak',
             request_method='GET')
def instrument_type_new(request):
    id = request.matchdict['id']

    institution = (Session.query(Institution)
                   .filter(Institution.id == id)
                   .all())

    if not institution:
        raise HTTPNotFound

    return {
        'institution': institution,
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
    safe_keys = ['instrument_type_id', 'name',
                 'active', 'description']
    safe_data = {}

    for key in data.keys():
        if key in safe_keys:
            safe_data[key] = data[key]

    instrument = Instrument(**safe_data)

    try:
        Session.add(instrument)
        Session.flush()
        Session.commit()
    except:
        Session.rollback()

    message = "Uspešno ste dodali aparat."
    request.session.flash(message)

    return HTTPFound(location=request.route_path('home'))
