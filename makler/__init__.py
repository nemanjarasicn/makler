from pyramid.config import Configurator
from pyramid.session import UnencryptedCookieSessionFactoryConfig

from sqlalchemy import engine_from_config
from zope.sqlalchemy import ZopeTransactionExtension

from .model.session import init_session


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    engine = engine_from_config(settings, 'sqlalchemy.')
    init_session(engine, extension=ZopeTransactionExtension())

    my_session_factory = UnencryptedCookieSessionFactoryConfig('makler')

    config = Configurator(
        settings=settings,
        session_factory=my_session_factory,
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

    config.scan('.views')
    return config.make_wsgi_app()
