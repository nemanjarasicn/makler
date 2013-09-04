## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<%def name="title()">Makler DB</%def>

<div class="row">
  <div class="large-4 columns">
    <select id="institutions-list" class="select full-width">
      % for institution in institutions:
        <option value="${institution.id}">${institution.name}</option>
      % endfor
    </select>
  </div>

  <div class="large-4 columns">
    <a href="${request.route_path('institution_new')}" class="button small round">Nova</a>
  </div>

  <div class="large-4 columns">
  </div>
</div>

<div class="row">
  <div class="large-4 columns">
    <select id="instrument-types-list" class="select full-width">
      % for instrument_type in instrument_types:
        <option value="${instrument_type.id}">${instrument_type.name}</option>
      % endfor
    </select>
  </div>

  <div class="large-4 columns">
    <a href="${request.route_path('instrument_type_new')}" class="button small round">Novi</a>
  </div>

  <div class="large-4 columns">
  </div>
</div>

<%block name="ready">
  $('#institutions-list').on("select2-selecting", function (e) {
    var url = "/institution/" + e.val
    window.location.href = url
  });

  $('#instrument-types-list').on("select2-selecting", function (e) {
    var url = "/instrument_type/" + e.val
    window.location.href = url
  });
</%block>
