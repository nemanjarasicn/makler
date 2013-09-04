# -*- coding: utf-8 -*-

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound

from ..model.institution import Institution
from ..model.session import Session


@view_config(route_name='institution_new',
             renderer='institution_form.mak',
             request_method='GET')
def institution_new(request):
    """Displays form for creating new institution"""

    institution = Institution()

    return {
        'form_action': request.route_path('institution_create'),
        'institution': institution
    }


@view_config(route_name='institution_edit',
             renderer='institution_form.mak',
             request_method='GET')
def institution_edit(request):
    """Displays form for editing existing institution"""

    id = request.matchdict['id']
    institution = (Session.query(Institution)
                   .filter(Institution.id == id)
                   .first())

    if not institution:
        raise HTTPNotFound

    return {
        'form_action': request.route_path('institution_update', id=id),
        'institution': institution
    }


@view_config(route_name='institution_create',
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

    message = "Uspešno ste dodali instituciju."
    request.session.flash(message)

    return HTTPFound(location=request.route_path('home'))
