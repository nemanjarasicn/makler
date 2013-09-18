## -*- coding: utf-8 -*-
<%inherit file="base_select2.mak"/>
<%namespace name="form" file="instrument_type_form.mak" />

<%def name="title()">Model analizatora</%def>

<div class="row">
  <div class="large-6 columns">
    ${form.instrument_type_form(instrument_type, request.route_path('instrument_type', id=instrument_type.id))}
  </div>
</div>

  <div class="row">
  <div class="large-12 columns">
  <h5>Ukupno aktivnih analizatora ${instruments_active} / ukupno instaliranih ${instruments_no} .</h5>

  <ul>
  % for i in instruments:
    <li><a href="${request.route_path('institution', id=i.id)}">${i.name} (${i.active or 0}/${i.installed})</a></li>
  % endfor
  </ul>

</div></div>