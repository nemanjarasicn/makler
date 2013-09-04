# -*- coding: utf-8 -*-

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound

from ..model.institution import Institution
from ..model.instrument import Instrument
from ..model.instrument import InstrumentType
from ..model.session import Session


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
    institution = (Session.query(Institution)
                   .filter(Institution.id == id)
                   .first())

    instruments = (Session.query(Instrument)
                   .filter(Instrument.institution_id == id)
                   .all())
    instrument_types = Session.query(InstrumentType).all()

    if not institution:
        raise HTTPNotFound

    return {
        'institution': institution,
        'instruments': instruments,
        'instrument_types': instrument_types,
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

    institution = Institution(**safe_data)
    try:
        Session.add(institution)
        Session.flush()
        Session.commit()
    except:
        Session.rollback()

    message = "Uspešno ste dodali ustanovu."
    request.session.flash(message)

    return HTTPFound(
        location=request.route_path('institution', id=institution.id))


@view_config(route_name='institution',
             request_method='POST')
def institution_update(request):
    """Updates institutions"""

    id = request.POST['id']
    institution = (Session.query(Institution)
                   .filter(Institution.id == id)
                   .first())

    if not institution:
        raise HTTPNotFound

    institution.name = request.POST['name']
    institution.address = request.POST['address']
    institution.city = request.POST['city']

    try:
        Session.commit()
    except:
        Session.rollback()

    message = "Uspešno ste ažurirali ustanovu."
    request.session.flash(message)

    return HTTPFound(location=request.route_path('institution', id=id))
