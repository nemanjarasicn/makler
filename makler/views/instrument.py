# -*- coding: utf-8 -*-
from itertools import groupby
from sqlalchemy import sql
from sqlalchemy import orm
from pyramid.view import view_config
from ..models import Instrument
from ..models import InstrumentType
from ..models import InstrumentTypeCategory


@view_config(route_name='instruments',
             renderer='instruments.mak',
             request_method='GET')
def instrumenti(request):

    instrument_types_q = (
        request.dbsession.query(InstrumentType)
        .order_by(InstrumentType.manufacturer, InstrumentType.name))

    i1 = orm.aliased(Instrument)
    i2 = orm.aliased(Instrument)

    inst = (
        orm.Query([
            i1.instrument_type_id,
            sql.func.count().label('installed')])
        .group_by(i1.instrument_type_id)
        .subquery())

    actv = (
        orm.Query([
            i2.instrument_type_id,
            sql.func.count().label('active')])
        .group_by(i2.instrument_type_id)
        .filter(i2.active)
        .subquery())

    itg = (
        request.dbsession.query(
            InstrumentType,
            inst.c.installed,
            actv.c.active
        )
        .outerjoin(inst, InstrumentType.id == inst.c.instrument_type_id)
        .outerjoin(actv, InstrumentType.id == actv.c.instrument_type_id)
        .order_by(InstrumentType.manufacturer, InstrumentType.name)
    )

    no_instruments = request.dbsession.query(
        sql.func.count(Instrument.id)).scalar()

    instrument_type_no = (
        request.dbsession.query(
            InstrumentTypeCategory.name,
            sql.func.count()
        )
        .join(Instrument.instrument_type)
        .join(InstrumentTypeCategory)
        .group_by(InstrumentType.category_id, InstrumentTypeCategory.name)
        .order_by(InstrumentType.category_id)
    )

    active_installed = [
        (t, active, installed)
        for t, installed, active in itg]

    instrument_types_grouped = groupby(
        active_installed, lambda x: x[0].manufacturer)

    return {

                'instrument_types': instrument_types_q.all(),
                'instrument_type_no': instrument_type_no.all(),
                'no_instruments': no_instruments,
                'instrument_types_grouped': instrument_types_grouped,

    }
