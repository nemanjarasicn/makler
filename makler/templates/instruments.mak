## -*- coding: utf-8 -*-

<%inherit file="base_select2.mak"/>

<h1>Modeli aparata</h1>
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


  <%block name="javascripts">
  ${parent.javascripts()}
  <script src="${request.static_url('makler:public/js/home.js')}"></script>
  </%block>
