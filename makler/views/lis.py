# -*- coding: utf-8 -*-
import transaction

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..models import Institution
from ..models import LabInformationSystem


@view_config(route_name='lis_edit',
             request_method='POST')
def lis_edit(request):

    _id = request.POST['institution_id']
    lis_id = request.POST['lis_id']

    institution = (request.dbsession.query(Institution)
                   .filter(Institution.id == _id).one())

    institution.lis_id = lis_id
    try:
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path('institution', id=_id))


@view_config(route_name='lis_new', request_method='POST')
def lis_new(request):

    data = dict(request.params)

    try:
        lis = LabInformationSystem(**data)
        request.dbsession.add(lis)
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.referer)
