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
    <h4>Dodaj novi aparat</h4>
    <select id="instrument-list" class="select">
        <option></option>
        % for ins_type in instrument_types:
            <option value="ins.type.id">${ins_type.name}</option>
        % endfor
    </select>
    <a href="${request.route_path('instrument_new', id=institution.id)}" class="small button round">Dodaj</a>
  </div>
</div>



<%block name="ready">
  $('#instrument-list').select2({
    placeholder: "izaberi tip",
    allowClear: true
  });
</%block>