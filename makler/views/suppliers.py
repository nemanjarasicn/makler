# -*- coding: utf-8 -*-
import transaction

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..model.supplier import Supplier
from ..model.session import Session


@view_config(route_name='supplier_new', request_method='POST')
def supplier_new(request):

    data = dict(request.params)

    suppliers = Supplier(**data)
    Session.add(suppliers)
    Session.flush()

    try:
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.referer)
