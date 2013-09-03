#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
from sqlalchemy import create_engine


def init_db(db_file):
    cwd = os.path.dirname(os.path.realpath(__file__))
    fullpath_db = os.path.abspath(
        os.path.join(cwd, db_file))

    engine = create_engine(
        'sqlite:///' + fullpath_db, echo=True)

    from model.base import meta
    from model import schema  # NOQA
    meta.create_all(bind=engine)


if __name__ == '__main__':
    init_db(sys.argv[1]) or sys.exit(1)
