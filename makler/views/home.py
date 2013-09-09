# -*- coding: utf-8 -*-
from pyramid.view import view_config
from ..model.session import Session
from ..model.instrument import Instrument
from ..model.instrument import InstrumentType
from ..model.institution import Institution


@view_config(route_name='home',
             renderer='home.mak',
             request_method='GET')
def home(request):
    instruments = Session.query(Instrument).all()
    institutions = Session.query(Institution).all()

    instrument_types = (Session.query(InstrumentType)
                        .order_by(InstrumentType.manufacturer).all())

    return {
        'instrument_types': instrument_types,
        'instruments': instruments,
        'institutions': institutions,
    }
