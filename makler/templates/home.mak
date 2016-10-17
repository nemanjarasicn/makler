## -*- coding: utf-8 -*-

<%inherit file="base_select2.mak"/>

<%def name="title()">Makler - Baza aparata</%def>

<div class="row no-print">
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
    <table class="makler">
      <thead>
        <tr>
          <th>Dom zdravlja</th>
          <th class="contract_warning_home">Ugovor</th>
          <th>Adresa</th>
          <th>Telefon</th>
        </tr>
      </thead>
      <tbody>
        % for institution in institutions:
        <tr>
          % if institution.instruments:
              <td><a href="${request.route_path('institution', id=institution.id)}"><strong>${institution.name}</strong></a></td>
          % else:
              <td><a href="${request.route_path('institution', id=institution.id)}">${institution.name}</a></td>
          % endif
          <td class="contract_warning_home">
            % if institution.num_of_contr_exp > 0:
              <a href="${request.route_path('institution', id=institution.id)}" title="Broj ugovora koji uskoro ističu: ${institution.num_of_contr_exp}">
                <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
              </a>
            % endif
          </td>
          <td><a href="${request.route_path('institution', id=institution.id)}">${institution.address}</a></td>
          <td><a href="${request.route_path('institution', id=institution.id)}">${institution.phone}</a></td>
        % endfor
        </tr>
      </tbody>
    </table>
  </div>
</div>

<%block name="javascripts">
${parent.javascripts()}
<script src="${request.static_url('makler:public/js/home.js')}"></script>
</%block>
