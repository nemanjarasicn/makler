#  -*- coding: utf-8 -*-
import transaction
import logging

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound, HTTPNotFound
from pyramid.httpexceptions import HTTPInternalServerError, HTTPBadRequest
from ..models import User, UserValidator, log_info



log = logging.getLogger(__name__)


@view_config(route_name='users',
             renderer='users.mak',
             request_method='GET')
def users(request):
    ''' Display list of users'''

    users = request.dbsession.query(User)
    return {
        'users': users,
    }


@view_config(route_name='user_new',
             renderer='user_edit.mak',
             request_method='GET')
def user_new(request):
    '''Display a form for adding new user'''

    user = User()
    return {
        'user': user,
        }


@view_config(route_name='user_new',
             request_method='POST')
def user_create(request):
    data = dict(request.params)
    if not data['password']:
        raise HTTPBadRequest('Morate uneti lozinku! ')

    '''Use formencode validator for validation of input date'''
    user = UserValidator().to_python(data)
    if not user:
        raise HTTPNotFound

    del user['confipass']
    try:
            user = User(**user)
            request.dbsession.add(user)
            transaction.commit()
            log_info(log, 'has made the new user ', request.authenticated_userid)
            return HTTPFound(location=request.route_path('home'))
    except Exception:
        log.exception('failed to make new user')
        raise HTTPInternalServerError(
                u"Greška! Obratite se tehničkoj podršci")


@view_config(route_name='user_edit',
             renderer='user_edit.mak',
             request_method='GET')
def user_edit(request):
    """Display a form for editing users.
    """
    id = request.matchdict['id']
    user = (request.dbsession.query(User).filter(User.id == id).first())
    if not user:
        raise HTTPNotFound

    users = request.dbsession.query(User).all()
    return {
        'users': users,
        'user': user,
    }


def get_login_user(request):
    ''' Return information about log on user'''

    user_login = request.authenticated_userid
    if user_login:
        user = (request.dbsession.query(User)
                .filter(User.username == user_login)
                .first())
        return user



@view_config(route_name='user_edit',
             request_method="POST")
def user_edit_update(request):
    id = request.matchdict['id']

    data = dict(request.params)

    user = (request.dbsession.query(User)
            .filter(User.id == id)
            .first())

    if not user:
        raise HTTPNotFound

    if not data['password']:
        del data['password']

# This is how we validate input parametars
    user_val = UserValidator().to_python(data)

    if not user_val:
        raise HTTPNotFound

    del user_val['confipass']

    request.dbsession.query(User).filter(User.id == id).update(user_val)
    try:
        transaction.commit()
        log_info(log, 'has edit user', request.authenticated_userid)
        return HTTPFound(location=request.route_path('home'))
    except Exception:
        log.exception('failed to edit user')
        raise HTTPInternalServerError(u"Greška! Obratite se tehničkoj podršci")
