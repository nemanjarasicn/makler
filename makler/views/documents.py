# -*- coding: utf-8 -*-
import transaction

import logging
import os
import uuid
import shutil
from datetime import date

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..models import Contract
from ..models import Document, log_info
from pyramid.response import FileResponse
from pyramid.response import Response

log = logging.getLogger(__name__)


@view_config(route_name='document_upload',
             request_method='POST')
def document_upload(request):
    """Upload file to server based on POST params.

    params: coid - contract id
            document - instance of FieldStorage class

    """

    dir_name = request.registry.settings.get('documents_path')
    if not dir_name:
        raise HTTPInternalServerError(u"Greška! Obratite se tehničkoj podršci")

    co_id = request.POST['coid']
    contract = (request.dbsession.query(Contract).filter(Contract.id == co_id).first())
    inst_id = contract.institution.id

    try:
        filename = request.POST['document'].filename
        input_file = request.POST['document'].file
    except AttributeError:
        return Response('Niste izabrali dokument')

    uuid_name = str(uuid.uuid4())

    # putanja do mesta gde cemo smestiti fajl
    path = dir_name + uuid_name[0:1] + '/' + uuid_name[1:2]

    # make dirs if they don't exist
    if not os.path.exists(path):
        os.makedirs(path)

    file_path = path + '/' + uuid_name

    # We first write to a temporary file to prevent incomplete files from being used.
    temp_file_path = file_path + '~'

    # Write the data to a temporary file
    input_file.seek(0)

    with open(temp_file_path, 'wb') as temp_file:
        shutil.copyfileobj(input_file, temp_file)

    # Now that we know the file has been fully saved to disk move it into place.
    os.rename(temp_file_path, file_path)

    upload_date = date.today()
    document = Document(original_name=filename, code_name=uuid_name,
                        contract=contract, upload_date=upload_date)
    try:
        request.dbsession.add(document)
        request.dbsession.flush()
        id = document.id
        transaction.commit()
        log_info(log, 'has made the new document with ID: ',
                 id, request.authenticated_userid)
    except Exception:
        log.error('failed to make new documment')
        request.dbsession.rollback()
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path('institution', id=inst_id))


@view_config(route_name='document_download',
             request_method='GET')
def document_download(request):

    dir_name = request.registry.settings.get('documents_path')

    doc_id = request.matchdict['id']
    document = (request.dbsession.query(Document)
                .filter(Document.id == doc_id).first())

    path_to_file_code_name = dir_name + document.code_name[0:1] + '/' + \
        document.code_name[1:2] + '/' + document.code_name
    path_to_file = dir_name + 'temp/' + \
        str(document.original_name.encode('utf8'))
    shutil.copy2(path_to_file_code_name, path_to_file)
    response = FileResponse(path_to_file, request)
    attachment_path = \
        str("attachment; filename=" + document.original_name.encode('utf8'))
    response.headers['Content-Disposition'] = attachment_path
    os.remove(path_to_file)

    return response
