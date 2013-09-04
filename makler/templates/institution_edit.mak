## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>
<%namespace name="form" file="institution_form.mak" />

<%def name="title()">Ustanova ${institution.name}</%def>

<div class="row">
  <div class="large-6 columns">
    ${form.institution_form(institution, request.route_path('institution', id=institution.id))}
  </div>
</div>

<div class="row">
  <div class="small-3 columns">
    <h4>Aparati</h4>
    <ul>
    % for instrument in instruments:
        <li><a href="${request.route_path('instrument', id=instrument.id)}">${instrument.name}</a></li>
    % endfor
    </ul>
  </div>
  <div class="small-9 columns">
    <a href="${request.route_path('instrument_new', id=institution.id)}" class="small button round">Dodaj novi</a>
  </div>
</div>