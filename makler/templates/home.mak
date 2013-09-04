## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<%def name="title()">Makler DB</%def>

<div class="row">
  <div class="large-4 columns">
    <select id="institutions-list" class="select">
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

<%block name="ready">
  $('#institutions-list').select2();
  $('#institutions-list').on("select2-selecting", function (e) {
    var base_url = "${request.route_path('institution_new')}"
    var institution_url = base_url + '/' + e.val
    window.location.href = institution_url
  });
</%block>
