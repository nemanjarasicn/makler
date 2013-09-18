# -*- coding: utf-8 -*-
import transaction
from itertools import groupby

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..model.instrument import InstrumentType
from ..model.instrument import InstrumentTypeCategory
from ..model.session import Session


@view_config(route_name='instrument_type_new',
             renderer='instrument_type_new.mak',
             request_method='GET')
def instrument_type_new(request):
    """Display a form for creating instrument type.
    """
    instrument_type = InstrumentType()
    categories = (Session.query(InstrumentTypeCategory))

    return {
        'instrument_type': instrument_type,
        'instrument_type_categories': categories.all()
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
    instrument_type_categories = (Session.query(InstrumentTypeCategory))

    if not instrument_type:
        raise HTTPNotFound

    return {
        'instrument_type': instrument_type,
        'instrument_type_categories': instrument_type_categories.all(),
        #'institution_groups': groupby(instrument_type.institutions, lambda x: x.name)
    }


@view_config(route_name='instrument_type_new',
             request_method="POST")
def instrument_type_create(request):
    data = dict(request.params)
    safe_keys = [
        'manufacturer',
        'name',
        'category_id']
    safe_data = {}

    for key in data.keys():
        if key in safe_keys:
            safe_data[key] = data[key]

    instrument_type = InstrumentType(**safe_data)

    try:
        Session.add(instrument_type)
        transaction.commit()
    except:
        raise HTTPInternalServerError

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

    if 'name' in request.POST and request.POST['name']:
        instrument_type.name = request.POST['name']
    if 'category_id' in request.POST and request.POST['category_id']:
        instrument_type.category_id = request.POST['category_id']
    if 'manufacturer' in request.POST and request.POST['manufacturer']:
        instrument_type.manufacturer = request.POST['manufacturer']

    try:
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path('instrument_type', id=id))
