## -*- coding: utf-8 -*-

<%inherit file="base_select2.mak"/>

<section>
  <h1>Izveštaji</h1>
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

<%block name="javascripts">
${parent.javascripts()}
<script src="${request.static_url('makler:public/js/home.js')}"></script>
</%block>
