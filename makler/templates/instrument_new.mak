## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

% for inst_type in instrument_types:
    ${inst_type.name}
% endfor