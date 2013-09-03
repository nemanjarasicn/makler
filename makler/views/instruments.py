# -*- coding: utf-8 -*-

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound

from ..model.instrument import Instrument
from ..model.session import Session


@view_config(route_name='instrument_create',
             request_method='POST')
def instrument_create(request):
    data = dict(request.params)
    instrument = Instrument(**data)
    Session.add(instrument)
    Session.flush()
    Session.commit()

    message = "Uspešno ste dodali aparat."
    request.session.flash(message)

    return HTTPFound(location=request.route_path('home'))
