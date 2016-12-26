# -*- coding: utf-8 -*-
import transaction
import logging

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..models import Supplier, log_info

log = logging.getLogger(__name__)


@view_config(route_name='supplier_new', request_method='POST')
def supplier_new(request):

    data = dict(request.params)

    try:
        suppliers = Supplier(**data)
        request.dbsession.add(suppliers)
        transaction.commit()
        log_info(log, 'has make the new supplier ', request.authenticated_userid)
    except Exception:
        log.exception('filed to make the new supplier')
        raise HTTPInternalServerError

    return HTTPFound(location=request.referer)
