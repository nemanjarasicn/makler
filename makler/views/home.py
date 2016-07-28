# -*- coding: utf-8 -*-
from itertools import groupby
from datetime import date, timedelta

from sqlalchemy import sql
from sqlalchemy import orm

from pyramid.view import view_config
from ..model.session import Session
from ..model.instrument import Instrument
from ..model.instrument import InstrumentType
from ..model.instrument import InstrumentTypeCategory
from ..model.institution import Institution


@view_config(route_name='home',
             renderer='home.mak',
             request_method='GET')
def home(request):

    institutions_q = Session.query(Institution)

    days_remain = int(request.registry.settings.get('days_remain', 30))

    institution_list = []
    for inst in institutions_q:
        inst.num_of_contr_exp = 0
        institution_list.append(inst)

        for co in inst.contracts:
            if co.valid_until:
                if (co.valid_until.date() - timedelta(days=days_remain) < date.today()) and (co.valid_until.date() >= date.today()):  # NOQA
                    inst.num_of_contr_exp += 1

    instrument_types_q = (
        Session.query(InstrumentType)
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
        Session.query(
            InstrumentType,
            inst.c.installed,
            actv.c.active
        )
        .outerjoin(inst, InstrumentType.id == inst.c.instrument_type_id)
        .outerjoin(actv, InstrumentType.id == actv.c.instrument_type_id)
        .order_by(InstrumentType.manufacturer, InstrumentType.name)
    )

    no_instruments = Session.query(sql.func.count(Instrument.id)).scalar()

    instrument_type_no = (
        Session.query(
            InstrumentTypeCategory.name,
            sql.func.count()
        )
        .join(Instrument.instrument_type)
        .join(InstrumentTypeCategory)
        .group_by(InstrumentType.category_id)
        .order_by(InstrumentType.category_id)
    )

    active_installed = [
        (t, active, installed)
        for t, installed, active in itg]

    instrument_types_grouped = groupby(
        active_installed, lambda x: x[0].manufacturer)

    return {
        'institutions': institution_list,
        'instrument_types': instrument_types_q.all(),
        'instrument_type_no': instrument_type_no.all(),
        'no_instruments': no_instruments,
        'instrument_types_grouped': instrument_types_grouped,
        'days_remain': days_remain
    }
