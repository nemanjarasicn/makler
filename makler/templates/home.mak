## -*- coding: utf-8 -*-
<%inherit file="base_select2.mak"/>

<%def name="title()">Makler DB</%def>

<div class="section-container auto" data-section>
  <section>
    <p class="title" data-section-title><a href="#panel1">Ustanove</a></p>
    <div class="content" data-section-content>
      <div class="row">
        <div class="large-8 columns">
          <select id="institutions-list" class="full-width">
            <option></option>
            % for institution in institutions:
            <option value="${institution.id}">${institution.name}</option>
            % endfor
          </select>
        </div>

        <div class="large-4 columns">
          <a href="${request.route_path('institution_new')}" class="button small round right">Nova ustanova</a>
        </div>
      </div>

      <div class="row">
        <div class="large-12 columns">
          <table class="ustanova">
            <thead>
              <tr>
                <th>Dom zdravlja</th>
                <th width="200">Adresa</th>
                <th>Telefon</th>
                ##<th>Kontakt osoba</th>
              </tr>
            </thead>
            <tbody>
              % for institution in institutions:
              <tr>
                <td><a href="${request.route_path('institution', id=institution.id)}">${institution.name}</td></a>
                <td><a href="${request.route_path('institution', id=institution.id)}">${institution.address}</td></a>
                <td><a href="${request.route_path('institution', id=institution.id)}">${institution.phone}</td></a>
                ##<td><a href="${request.route_path('institution', id=institution.id)}">${institution.contacts[0].name (institution.contacts[0].phone) if institution.contacts else ''} </td></a>
                % endfor
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </section>
  <section>
    <p class="title" data-section-title><a href="#panel2">Modeli aparata</a></p>
    <div class="content" data-section-content>
      <div class="row">
        <div class="large-8 columns">
          <select id="instrument-types-list" class="full-width">
            <option></option>
            % for instrument_type in instrument_types:
            <option value="${instrument_type.id}">${instrument_type.name}</option>
            % endfor
          </select>
        </div>

        <div class="large-4 columns">
          <a href="${request.route_path('instrument_type_new')}" class="button small round right">Novi model</a>
        </div>

      </div>
      <div class="row">
        <div class="large-12 columns">
          <table class="ustanova">
            <thead>
              <tr>
                <th>Proizvođač</th>
                <th>Model</th>
                <th>Tip</th>
              </tr>
            </thead>
            <tbody>
              % for instrument_type in instrument_types:
              <tr>
                <td><a href="${request.route_path('instrument_type', id=instrument_type.id)}">${instrument_type.manufacturer}</td></a>
                <td><a href="${request.route_path('instrument_type', id=instrument_type.id)}">${instrument_type.name}</td></a>
                <td><a href="${request.route_path('instrument_type', id=instrument_type.id)}">${instrument_type.type}</td></a>
                % endfor
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

  </section>
</div>


<%block name="javascripts">
${parent.javascripts()}
<script src="${request.static_url('makler:public/js/home.js')}"></script>
</%block>
