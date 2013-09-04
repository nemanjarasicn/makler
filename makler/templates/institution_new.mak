## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>
<%namespace name="form" file="institution_form.mak" />

<%def name="title()">Nova ustanova</%def>

<div class="row">
  <div class="large-6 columns">
    ${form.institution_form(institution, request.route_path('institution_new))}
  </div>
</div>
