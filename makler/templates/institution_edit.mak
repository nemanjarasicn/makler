## -*- coding: utf-8 -*-
<%inherit file="base_select2.mak"/>
<%namespace name="form" file="institution_form.mak" />

<%def name="title()">Ustanova ${institution.name}</%def>

<div class="row">
  <div class="large-6 columns">
    ${form.institution_form(institution, request.route_path('institution', id=institution.id))}
  </div>
</div>

<div class="row">
  <div class="large-6 columns">
    <form action="${request.route_path('contact_new', id=institution.id)}" method="POST" style="display:inline;">
      <input type="hidden" name="institution_id" value="${institution.id}" />
      <div class="large-5 columns">
        <input type="text" name="name" placeholder="Ime" />
      </div>
      <div class="large-5 columns">
        <input type="text" name="telephone" placeholder="Broj telefona" />
      </div>
      <div class="large-2 columns">
        <button type="submit" class="tiny round">Dodaj</button>
      </div>
    </form>
  </div>
</div>

<div class="row">
  <div class="large-6 columns">
    <h4 style="display:inline;">Aparati</h4>
    <a href="#" class="tiny round button" id="ajax-test" data-reveal-id="novi-instrument">Dodaj</a>
    <ul>
      % for instrument in instruments:
      <li>
        <input class="instrument-activation"
               type="checkbox" name="${instrument.id}"
               ${'checked' if instrument.active else ''} />
        <a class="instrument" data-id="${instrument.id}"
           href="${request.route_path('instrument', id=instrument.id)}">
          ${instrument.instrument_type.manufacturer} ${instrument.instrument_type.name} ${instrument.description}
        </a>
        <form action="${request.route_path('instrument_delete')}" method="POST" style="display:inline">
          <input type="hidden" name="id" value="${instrument.id}" />
          <button class="delete" type="submit"></button>
        </form>
      </li>
      % endfor
    </ul>
  </div>
</div>

<div id="novi-instrument" class="reveal-modal">
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
    <a id="cancel-instrument-add" class="button small round">Odustani</a>
  </form>
  <a class="close-reveal-modal">&#215;</a>
</div>

<%block name="javascripts">
  ${parent.javascripts()}
  <script src="${request.static_url('makler:public/js/institution_edit.js')}"></script>
</%block>
