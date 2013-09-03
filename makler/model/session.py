# -*- coding: utf-8 -*-
# vim: set tabstop=4 shiftwidth=4 softtabstop=4 expandtab:

from sqlalchemy.orm import scoped_session, sessionmaker

# Global session manager.  Session() returns the session object
# appropriate for the current web request.
# It must be initialised separately, cause params are not known at first
# import.
Session = sessionmaker(autocommit=False, autoflush=False)


def init_session(bind, **kwargs):
    """Initialises session to config params."""
    global Session
    kwargs['autoflush'] = kwargs.get('autoflush', False)

    Session = scoped_session(sessionmaker(bind=bind, **kwargs))
