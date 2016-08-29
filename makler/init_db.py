#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

from ConfigParser import ConfigParser

from sqlalchemy import create_engine

from models import *


def init_db(config_filename):

    config = ConfigParser()
    config.read(config_filename)

    engine_url = config.get('app:main', 'sqlalchemy.url')
    engine = create_engine(engine_url)

    meta.create_all(bind=engine)

if __name__ == "__main__":
    init_db(sys.argv[1])
