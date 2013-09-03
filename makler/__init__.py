from pyramid.config import Configurator
from sqlalchemy import engine_from_config

from .models import Instrument
from .models import InstrumentType
from .models import Institution


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(settings=settings)
    config.add_static_view('public', 'public', cache_max_age=3600)
    config.add_route('home', '/')
    config.scan('views')
    return config.make_wsgi_app()
