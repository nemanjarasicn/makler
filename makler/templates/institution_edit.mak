## -*- coding: utf-8 -*-
<%inherit file="base_select2.mak"/>
<%namespace name="form" file="institution_form.mak" />

<%def name="title()">Ustanova ${institution.name}</%def>

<div class="row">
  <div class="large-6 columns">
    ${form.institution_form(institution, request.route_path('institution', id=institution.id))}
  </div>

  <div class="large-6 columns">
    <h4 style="display:inline;">Kontakti</h4>
    <a href="" class="tiny round button add" data-reveal-id="novi-kontakt">Dodaj</a>
    % for contact in institution.contacts:
    <div class="row">
      <div class="large-6 columns kontakti">
        <p>${contact.name}</p>
      </div>
      <div class="large-3 columns">
        <p>${contact.telephone}</p>
      </div>
      <div class="large-3 columns">
        <form action="${request.route_path('contact_delete')}" method="POST" style="display:inline">
          <input type="hidden" name="id" value="${contact.id}" />
            <button class="delete" type="submit"></button>
        </form>
      </div>
    </div>
    % endfor
  </div>
</div>

<div class="row">
  <div class="large-12 columns">
    <h4 style="display:inline;">Aparati</h4>
      <a href="" class="tiny round button add" data-reveal-id="novi-instrument">Dodaj</a>

      <ul>
        % for instrument in instruments:
        <li>
          <input class="instrument-activation"
                type="checkbox" name="${instrument.id}"
                ${'checked' if instrument.active else ''} />
          <a class="instrument" data-id="${instrument.id}"
             href="${request.route_path('instrument', id=instrument.id)}">
             ${instrument.instrument_type.manufacturer} ${instrument.instrument_type.name} ${instrument.description} ${instrument.installed}
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
      <button class="small round button disabled" type="submit" style="margin-top:10px;">Dodaj</button>
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
