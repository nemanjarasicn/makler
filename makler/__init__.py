import zope.sqlalchemy

from pyramid.config import Configurator
from pyramid.session import SignedCookieSessionFactory

from sqlalchemy import engine_from_config
from sqlalchemy.orm import sessionmaker


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

    config.add_request_method(
        # r.tm is the transaction manager used by pyramid_tm
        lambda r: get_tm_session(session_factory, r.tm),
        'dbsession', reify=True
    )

    config.add_static_view('public', 'public', cache_max_age=3600)
    config.add_route('home', '/')

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
