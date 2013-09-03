# -*- coding: utf-8 -*-

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound


@view_config(route_name='instrument_create',
             request_method='POST')
def instrument_create(request):
    return HTTPFound(location=request.route_path('home'))
