import zope.sqlalchemy

from pyramid.config import Configurator
from pyramid.session import SignedCookieSessionFactory

from sqlalchemy import engine_from_config
from sqlalchemy.orm import sessionmaker
from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy
from pyramid.security import Allow
from pyramid.security import Authenticated
from pyramid.security import Everyone

from makler.views.users import get_login_user


class RootFactory(object):
    __acl__ = [
        (Allow, Everyone, 'all'),
        (Allow, Authenticated, 'base'),
    ]

    def __init__(self, request):
        pass


def get_tm_session(session_factory, transaction_manager):
    """
    This function will hook the session to the transaction manager which
    will take care of commiting any changes.
    """
    dbsession = session_factory()
    zope.sqlalchemy.register(
        dbsession, transaction_manager=transaction_manager)
    return dbsession


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    engine = engine_from_config(settings, 'sqlalchemy.')
    session_factory = sessionmaker(bind=engine)
    my_session_factory = SignedCookieSessionFactory('itsaseekreet')

    config = Configurator(settings=settings,
                          session_factory=my_session_factory)

    config.registry['dbsession_factory'] = session_factory

    authn_policy = AuthTktAuthenticationPolicy(
        'youllneverguessit',
        hashalg='sha1',)
    authz_policy = ACLAuthorizationPolicy()

    config = Configurator(
        settings=settings,
        root_factory=RootFactory
    )
    config.include('pyramid_mako')

    config.set_authentication_policy(authn_policy)
    config.set_authorization_policy(authz_policy)
    config.set_default_permission('base')
    config.set_session_factory(my_session_factory)

    config.add_request_method(
        # r.tm is the transaction manager used by pyramid_tm
        lambda r: get_tm_session(session_factory, r.tm),
        'dbsession', reify=True
    )
    config.add_request_method(get_login_user, 'user', reify=True)

    config.add_static_view('public', 'public', cache_max_age=3600)
    config.add_route('home', '/')
    config.add_route('reports', '/reports')
    config.add_route('instruments', '/instruments')
    config.add_route('supplier', '/suppliers')
    config.add_route('supplier_form', '/suppliers/{id}')
    config.add_route('login', '/login')
    config.add_route('logout', '/logout')

    config.add_route('users', '/users')
    config.add_route('user_new', '/user_new')
    config.add_route('user_edit', '/user_edit/{id}')

    config.add_route('institution_new', '/institution')
    config.add_route('institution', '/institution/{id}')

    config.add_route('contact_new', '/institution/{id}/contact')
    config.add_route('contact_delete', '/delete/contact')

    config.add_route('instrument_new', '/institution/{id}/instrument')
    config.add_route('instrument', '/instrument/{id}')
    config.add_route('instrument_delete', '/delete/instrument')

    config.add_route('instrument_type_new', '/instrument_type')
    config.add_route('instrument_type', '/instrument_type/{id}')

    config.add_route('lis_edit', '/institution/{id}/lis')
    config.add_route('lis_new', '/lis')

    config.add_route('contract_new', '/contract_new/{id}')
    config.add_route('contract_edit', '/contract_edit/{id}')

    config.add_route('document_upload', '/document_upload')
    config.add_route('document_download', '/document_download/{id}')

    config.add_route('supplier_new', '/supplier')

    config.scan('.views')
    return config.make_wsgi_app()
