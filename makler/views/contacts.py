# -*- coding: utf-8 -*-

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..model.instrument import Instrument
from ..model.contact import Contact
from ..model.session import Session


@view_config(route_name='contact_new',
             request_method='POST')
def contact_new(request):
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


@view_config(route_name='contact_delete',
             request_method='POST')
def contact_delete(request):

    institution_id
    contact = Session.query(Contact).filter(Contact.id == id).first()
    if not contact:
        raise HTTPNotFound

    try:
        Session.delete(contact)
        Session.flush()
        Session.commit()
    except:
        Session.rollback()
        raise HTTPInternalServerError

    return HTTPFound(
        location=request.route_path('institution', id=institution_id))
