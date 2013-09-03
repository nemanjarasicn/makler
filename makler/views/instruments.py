# -*- coding: utf-8 -*-

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound

from ..model.instrument import Instrument
from ..model.session import Session


@view_config(route_name='instrument_create',
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
