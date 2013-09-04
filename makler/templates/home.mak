## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<%def name="title()">Makler DB</%def>

<div class="row">
  <div class="large-4 columns">
    <select class="chosen">
      % for institution in institutions:
        <option value="${institution.id}">${institution.name}</option>
      % endfor
    </select>
  </div>

  <div class="large-4 columns">
    <button class="small">Nova</button>
  </div>

  <div class="large-4 columns">
  </div>
</div>

<%block name="ready">
  $('.chosen').chosen();
</%block>
