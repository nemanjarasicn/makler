# -*- coding: utf-8 -*-
import transaction
import logging

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..models import Supplier

log = logging.getLogger(__name__)


@view_config(route_name='supplier_new', request_method='POST')
def supplier_new(request):

    data = dict(request.params)
    user_login = request.authenticated_userid

    try:
        suppliers = Supplier(**data)
        request.dbsession.add(suppliers)
        request.dbsession.flush()
        id = suppliers.id
        transaction.commit()
        log.info('User: %s ,has made new supplier with ID: %s', user_login, id)
    except Exception:
        raise HTTPInternalServerError

    return HTTPFound(location=request.referer)
