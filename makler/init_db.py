#!/usr/bin/env python
# -*- coding: utf-8 -*-

from sqlalchemy import create_engine


engine = create_engine(
    'sqlite:////home/bojan/dev/maklerdb/makler.sqlite', echo=True)

from model.base import meta
from model import schema  # NOQA
meta.create_all(bind=engine)
