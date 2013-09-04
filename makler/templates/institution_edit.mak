## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>
<%namespace name="form" file="institution_form.mak" />

<%def name="title()">Ustanova ${institution.name}</%def>

<div class="row">
  <div class="large-6 columns">
    ${form.institution_form(institution, request.route_path('institution', id=institution.id))}
  </div>
</div>
