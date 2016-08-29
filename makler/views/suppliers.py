# -*- coding: utf-8 -*-
import transaction

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..models import Supplier


@view_config(route_name='supplier_new', request_method='POST')
def supplier_new(request):

    data = dict(request.params)

    try:
        suppliers = Supplier(**data)
        request.dbsession.add(suppliers)
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.referer)
