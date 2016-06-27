## -*- coding: utf-8 -*-
<%!
  from datetime import date, timedelta
%>
<%inherit file="base_select2.mak"/>

<%def name="title()">Makler DB</%def>

<div class="section-container auto" data-section>
  <section>
    <p class="title" data-section-title><a href="#panel1">Ustanove</a></p>
    <div class="content" data-section-content>
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
                ##<th>Kontakt osoba</th>
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
                  % for co in institution.contracts:
                    % if (co.valid_until != None):
                      % if (co.valid_until.date() - timedelta(days=days_remain) < date.today()) and (co.valid_until.date() > date.today()):
                        <a href="${request.route_path('institution', id=institution.id)}">
                          <span class="dot expires_soon"></span><span class="contract_warning_small"></span>
                        </a>
                      % elif co.valid_until.date() > date.today():
                      % elif co.valid_until.date() < date.today():
                      % else:
                        <a href="${request.route_path('institution', id=institution.id)}">
                          <span class="dot expired_today"></span><span style="margin:10px"></span>
                        </a>
                      % endif
                    % endif
                  % endfor
                </td>
                <td><a href="${request.route_path('institution', id=institution.id)}">${institution.address}</a></td>
                <td><a href="${request.route_path('institution', id=institution.id)}">${institution.phone}</a></td>
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
      <div class="row no-print">
        <div class="large-8 columns">
          <select id="instrument-types-list" class="full-width">
            <option></option>
            % for instrument_type in instrument_types:
            <option value="${instrument_type.id}">${instrument_type.manufacturer} &nbsp; ${instrument_type.name}</option>
            % endfor
          </select>
        </div>

        <div class="large-4 columns">
          <a href="${request.route_path('instrument_type_new')}" class="button small round right">Novi model</a>
        </div>

      </div>
      <div class="row">
        <div class="large-12 columns">
          <table class="makler full-width">
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
                <td><a href="${request.route_path('instrument_type', id=instrument_type.id)}">${instrument_type.category.name if instrument_type.category else ''}</td></a>
                % endfor
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </section>

  <section>
     <p class="title" data-section-title><a href="#panel3">Izveštaji</a></p>
    <div class="content" data-section-content>
     <p>Ukupno instaliranih aparata: <strong>${no_instruments}</strong></p>
     <ul>
      % for i in instrument_type_no:
        <li class="instrument_tip">${i[0]}: <strong>${i[1]}</strong></li>
      % endfor
      </ul>
      % for manufacturer, types in instrument_types_grouped:
        <h5>${manufacturer}</h5>
          <ul class="two-columns panel radius">
        % for t, active, installed in types:
           % if installed:
           <li><strong><a href="${request.route_path('instrument_type', id=t.id)}">${t.name} (${installed}/${active})</a></strong></li>
           % else:
           <li><a href="${request.route_path('instrument_type', id=t.id)}">${t.name}</a></li>
           % endif
        % endfor
      </ul>
      % endfor

    </div>
  </section>
</div>


<%block name="javascripts">
${parent.javascripts()}
<script src="${request.static_url('makler:public/js/home.js')}"></script>
</%block>
