# -*- coding: utf-8 -*-
import transaction

import os
import uuid
import shutil
from datetime import date

from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPInternalServerError

from ..model.contract import Contract
from ..model.document import Document
from ..model.session import Session
from pyramid.response import FileResponse


@view_config(route_name='document_upload',
             request_method='POST')
def document_upload(request):

    dir_name = 'makler/documents/'

    co_id = request.POST['coid']
    contract = Session.query(Contract).filter(Contract.id == co_id).first()
    inst_id = contract.institution.id

    try:
        filename = request.POST['document'].filename
    except:
        return HTTPFound(location=request.route_path(
                         'institution', id=inst_id))

    input_file = request.POST['document'].file
    uuid_name = os.path.join('%s' % uuid.uuid4())
    path = dir_name + uuid_name[0:1] + '/' + uuid_name[1:2]
    os.makedirs(path)
    file_path = path + '/' + uuid_name
    temp_file_path = file_path + '~'
    input_file.seek(0)

    with open(temp_file_path, 'wb') as output_file:
        shutil.copyfileobj(input_file, output_file)

    os.rename(temp_file_path, file_path)

    upload_date = date.today()
    document = Document(original_name=filename, code_name=uuid_name,
                        contract=contract, upload_date=upload_date)
    Session.add(document)

    try:
        Session.flush()
        transaction.commit()
    except:
        raise HTTPInternalServerError

    return HTTPFound(location=request.route_path(
            'institution', id=inst_id))


@view_config(route_name='document_download',
             request_method='GET')
def document_download(request):

    dir_name = 'makler/documents/'

    doc_id = request.matchdict['id']
    document = Session.query(Document).filter(Document.id == doc_id).first()

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
