# -*- coding: utf-8 -*-
import logging

from pyramid.view import view_config
from ..models import User

from pyramid.httpexceptions import HTTPFound
from pyramid.response import Response
from pyramid.security import authenticated_userid
from pyramid.security import remember
from pyramid.security import forget
from pyramid.view import forbidden_view_config


log = logging.getLogger(__name__)


@view_config(route_name='login', renderer='login.mak', permission='all')
def login(request):

    login_url = request.route_url('login')
    referrer = request.url

    if referrer == login_url:
        referrer = '/'  # never use login form itself as came_from

    came_from = request.params.get('came_from', referrer)
    message = ''
    login = ''
    password = ''
    # This part might change, just following tutorial
    if 'submit' in request.params:
        login = request.params['login']
        password = request.params['password']

        user = (request.dbsession.query(User)
                .filter(User.username == login)
                .first())
        if user and user.validate_password(password):
            headers = remember(request, login)
            return HTTPFound(
                location="/",
                headers=headers)
        message = True

    return dict(
        message=message,
        url=request.application_url + '/login',
        came_from=came_from,
        login=login,
        password=password,
    )


@view_config(route_name='logout')
def logout(request):
    headers = forget(request)
    return HTTPFound(
        location=request.route_url('login'),
        headers=headers)


#
# Forward 403 to login if user is not logged in.
#
@forbidden_view_config()
def forbidden(request):
    if authenticated_userid(request):
        came_from = request.referer
        return Response(
            'You are not allowed. '
            'Go <a href="{url}">back</a>!'.format(url=came_from),
            status='401 Unauthorized')
    return HTTPFound(location=request.route_url('login'))
