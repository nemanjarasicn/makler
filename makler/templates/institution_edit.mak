## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>
<%namespace name="form" file="institution_form.mak" />

<%def name="title()">Ustanova ${institution.name}</%def>

<div class="row">
  <div class="large-6 columns">
    ${form.institution_form(institution, request.route_path('institution', id=institution.id))}
  </div>
</div>

<div class="row">
  <div class="small-3 columns">
    <h4>Aparati</h4>
    <ul>
    % for instrument in instruments:
        <li>
            <input class="instrument-activation"
                   type="checkbox" name="${instrument.id}"
                   ${'checked' if instrument.active else ''} />
            <a href="${request.route_path('instrument', id=instrument.id)}">${instrument.name}</a>
            <form action="${request.route_path('instrument_delete')}" method="POST" style="display:inline">
                <input type="hidden" name="id" value="${instrument.id}" />
                <button class="tiny round alert button" type="submit">x</button>
            </form>
        </li>
    % endfor
    </ul>
  </div>
  <div class="small-9 columns">
    <form action="${request.route_path('instrument_new', id=institution.id)}" method="post">
      <input type="hidden" name="institution_id" value="${institution.id}" />
      <h4>Dodaj novi aparat</h4>
        <select id="instrument-list" name="instrument_type_id" class="select">
          % for instrument_type in instrument_types:
            <option value="${instrument_type.id}">${instrument_type.name}</option>
          % endfor
    </select>
    <button class="small round" type="submit">Dodaj</button>
    </form>
  </div>
</div>



<%block name="ready">
  $('.instrument-activation').click(function () {
    var url = '/instrument/' + $(this).attr('name');

    // TODO: There has to be a better way to do this
    if ($(this).is(':checked')) {
      var data = {
        'active': 'True'
      };
    }
    else {
      var data = {}
    }

    $.post(url, data)
  });
</%block>
