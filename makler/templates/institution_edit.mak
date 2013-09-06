## -*- coding: utf-8 -*-
<%inherit file="base_select2.mak"/>
<%namespace name="form" file="institution_form.mak" />

<%def name="title()">Ustanova ${institution.name}</%def>

<div class="row">
  <div class="large-6 columns">
    ${form.institution_form(institution, request.route_path('institution', id=institution.id))}
  </div>
</div>

<%block name="modals">
  <div id="novi-instrument" class="small reveal-modal">
    <form action="${request.route_path('instrument_new', id=institution.id)}" method="post">
      <input type="hidden" name="institution_id" value="${institution.id}" />
      <h4>Dodaj novi aparat</h4>
      <select id="instrument-types-list" name="instrument_type_id" class="full-width">
        <option></option>
        % for instrument_type in instrument_types:
        <option value="${instrument_type.id}">${instrument_type.name}</option>
        % endfor
      </select>
      <button class="small round disabled" type="submit" style="margin-top:10px;">Dodaj</button>
      <a class="small round cancel button">Odustani</a>
    </form>
    <a class="close-reveal-modal">&#215;</a>
  </div>

  <div id="novi-kontakt" class="small reveal-modal">
    <h4>Dodaj novi kontakt</h4>
    <form action="${request.route_path('contact_new', id=institution.id)}" method="POST" style="display:inline;">
      <div class="row">
        <input type="hidden" name="institution_id" value="${institution.id}" />
        <div class="large-6 columns">
          <input type="text" name="name" placeholder="Ime" />
        </div>
        <div class="large-6 columns">
          <input type="text" name="telephone" placeholder="Broj telefona" />
        </div>
      </div>
      <div class="row">
      <button type="submit" class="small round button">Dodaj</button>
      <a class="small round cancel button">Odustani</a>
      </div>
    </form>
    <a class="close-reveal-modal">&#215;</a>
  </div>
</%block>

<%block name="javascripts">
${parent.javascripts()}
<script src="${request.static_url('makler:public/js/institution_edit.js')}"></script>
</%block>
