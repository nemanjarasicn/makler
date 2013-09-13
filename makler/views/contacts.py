# -*- coding: utf-8 -*-
import transaction

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..model.contact import Contact
from ..model.session import Session


@view_config(route_name='contact_new',
             request_method='POST')
def contact_new(request):
    data = dict(request.params)
    safe_keys = ['institution_id', 'name', 'telephone']
    safe_data = {}

    for key in data.keys():
        if key in safe_keys:
            safe_data[key] = data[key]

    contact = Contact(**safe_data)

    # If name/phone combination already exists, do nothing
    if (Session.query(Contact)
            .filter(Contact.name == contact.name)
            .filter(Contact.institution_id == contact.institution_id)
            .filter(Contact.telephone == contact.telephone)
            .all()):
        return HTTPFound(location=request.route_path(
                         'institution', id=data['institution_id']))

    try:
        Session.add(contact)
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path(
        'institution', id=data['institution_id']))


@view_config(route_name='contact_delete',
             request_method='POST')
def contact_delete(request):

    id = request.POST['id']
    contact = Session.query(Contact).filter(Contact.id == id).first()

    if not contact:
        raise HTTPNotFound

    institution_id = contact.institution.id
    try:
        Session.delete(contact)
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(
        location=request.route_path('institution', id=institution_id))
