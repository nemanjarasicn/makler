## -*- coding: utf-8 -*-
<%inherit file="base_select2.mak"/>
<%namespace name="form" file="institution_form.mak" />

<%def name="title()"></%def>

<div class="row">
  <div class="large-6 columns">
    <h3>${institution.name}</h3>
    ${form.institution_form(institution, request.route_path('institution', id=institution.id))}
  </div>

  <div class="large-6 columns">

    <div class="row">
      <div class="large-6 columns">
        <h3>Kontakti</h3>
      </div>

      <div class="large-6 columns no-print">
        <h5><a href="" class="tiny round button right" data-reveal-id="novi-kontakt">Dodaj</a></h5>
      </div>
    </div>

      <div class="row">
        <div class="large-12 columns">
        <table class="makler aparati full-width">
          <thead>
            <tr>
              <th>Ime i prezime</th>
              <th>Telefon</th>
              <th width="50" class="no-print">Briši</th>
            </tr>
          </thead>
          <tbody>
            % for contact in institution.contacts:
            <tr>
              <td>${contact.name}</td>
              <td>${contact.telephone}</td>
              <td class="no-print">
                <form action="${request.route_path('contact_delete')}" method="POST" style="display:inline">
                  <input type="hidden" name="id" value="${contact.id}" />
                  <button class="delete" type="submit"></button>
                </form>
              </td>
            </tr>
            % endfor
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="large-12 columns">
    <h4 style="display:inline;">Aparati</h4>
      <a href="" class="tiny round button add no-print" data-reveal-id="novi-instrument">Dodaj</a>

      <table class="makler aparati full-width">
        <thead>
          <tr>
            <th>Aktivan</th>
            <th>Proizvođač</th>
            <th>Ima analizatora</th>
            <th>Starost</th>
            <th>Broj uzoraka</th>
            <th>Odeljenje</th>
            <th>Komentar</th>
            <th width="50" class="no-print">Briši</th>
          </tr>
        </thead>
        <tbody>

          % for instrument in instruments:
          <tr>
            <td>
              <input class="instrument-activation"
                    type="checkbox" name="${instrument.id}"
                    ${'checked' if instrument.active else ''} />
            </td>
            <td>${instrument.instrument_type.manufacturer}</td>
            <td><a href="${request.route_path('instrument', id=instrument.id)}">${instrument.instrument_type.name}</td>
            <td>${instrument.age}</td>
            <td>${instrument.sample_numbers}</td>
            <td>${instrument.department}</td>
            <td>${instrument.description}</td>
            <td class="no-print">
              <form action="${request.route_path('instrument_delete')}" method="POST" style="display:inline">
                <input type="hidden" name="id" value="${instrument.id}" />
                  <button class="delete" type="submit"></button>
              </form>
            </td>
          </tr>
            % endfor
        </tbody>

      </table>
  </div>
</div>

<%block name="modals">
  <div id="novi-instrument" class="small reveal-modal no-print">
    <form action="${request.route_path('instrument_new', id=institution.id)}" method="post">
      <input type="hidden" name="institution_id" value="${institution.id}" />
      <h4>Dodaj novi aparat</h4>

      <div class="row" style="margin-bottom: 10px;">
        <div class="large-12 columns">
          <select id="instrument-types-list" name="instrument_type_id" class="full-width">
            <option></option>
            % for instrument_type in instrument_types:
            <option value="${instrument_type.id}">${instrument_type.name}</option>
            % endfor
          </select>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Odeljenje</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="department" class="right-label" placeholder="Odeljenje" />
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Starost</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="age" class="right-label" placeholder="Starost opreme">
          </input>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Broj uzoraka</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="sample_numbers" class="right-label" placeholder="Broj uzoraka">
          </input>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Komentar</label>
        </div>
        <div class="small-9 columns">
          <textarea name="description" placeholder="Komentar" style="word-break:break-all;"></textarea>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Aktivan</label>
        </div>
        <div class="small-9 columns">
          <input type="checkbox" value="1" name="active" style="position:absolute; top:6px;" />
        </div>
      </div>
    <button class="small round button disabled" type="submit" style="margin-top:10px;">Dodaj</button>
    <a class="small round cancel button">Odustani</a>
    </form>
    <a class="close-reveal-modal">&#215;</a>
  </div>

  <div id="novi-kontakt" class="small reveal-modal no-print">
    <div class="row">
      <div class="large-12 columns">
        <h4>Dodaj novi kontakt</h4>
      </div>
    </div>

  <div class="row">
    <form action="${request.route_path('contact_new', id=institution.id)}" method="POST" style="display:inline;">
        <div class="large-6 columns">
          <input type="hidden" name="institution_id" value="${institution.id}" />
          <input type="text" name="name" placeholder="Ime i prezime" />
        </div>
        <div class="large-6 columns">
          <input type="text" name="telephone" placeholder="Broj telefona" />
        </div>
  </div>

  <div class="row">
    <div class="large-12 columns">
      <button type="submit" class="small round button">Dodaj</button>
      <a class="small round cancel button">Odustani</a>
    </form>
  </div>
    <a class="close-reveal-modal">&#215;</a>

</%block>

<%block name="javascripts">
${parent.javascripts()}
<script src="${request.static_url('makler:public/js/institution_edit.js')}"></script>
</%block>
