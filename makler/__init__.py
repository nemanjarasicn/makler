from pyramid.config import Configurator
from sqlalchemy import engine_from_config

from .model.session import init_session


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    engine = engine_from_config(settings, 'sqlalchemy.')
    init_session(engine)

    config = Configurator(settings=settings)
    config.add_static_view('public', 'public', cache_max_age=3600)

    # Routes
    config.add_route('home', '/')

    config.scan('.views')
    return config.make_wsgi_app()
