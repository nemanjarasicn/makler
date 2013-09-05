## -*- coding: utf-8 -*-
<%inherit file="base_select2.mak"/>
<%namespace name="form" file="instrument_type_form.mak" />

<%def name="title()">Novi model analizatora</%def>

<div class="row">
  <div class="large-6 columns">
    ${form.instrument_type_form(instrument_type, request.route_path('instrument_type_new'))}
  </div>
</div>
