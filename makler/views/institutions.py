# -*- coding: utf-8 -*-

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound

from ..model.institution import Institution
from ..model.session import Session


@view_config(route_name='institution_create',
             request_method='POST')
def institution_create(request):

    data = dict(request.params)
    institution = Institution(**data)
    Session.add(institution)
    Session.flush()
    Session.commit()

    message = "Uspešno ste dodali instituciju."
    request.session.flash(message)

    return HTTPFound(location=request.route_path('home'))
