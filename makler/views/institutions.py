# -*- coding: utf-8 -*-

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound

from ..model.institution import Institution
from ..model.session import Session


@view_config(route_name='institution_create',
             request_method='POST')
def institution_create(request):

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
