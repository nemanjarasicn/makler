# -*- coding: utf-8 -*-
from pyramid.view import view_config
from ..model.session import Session
from ..model.instrument import Instrument
from ..model.institution import Institution


@view_config(route_name='home',
             renderer='home.mak',
             request_method='GET')
def home(request):
    instruments = Session.query(Instrument).all()
    institutions = Session.query(Institution).all()

    return {
        'action_add_instrument': request.route_url('instrument_create'),
        'action_add_institution': request.route_url('institution_create'),
        'instruments': instruments,
        'institutions': institutions,
    }
