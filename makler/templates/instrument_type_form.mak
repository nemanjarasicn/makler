## -*- coding: utf-8 -*-

<%! from itertools import groupby %>

<%def name="instrument_type_form(instrument_type, form_action)">
  <form action="${form_action}" method="post">
    <input type="hidden" name="id" value="${instrument_type.id}" />

    <fieldset>
      <legend>Model analizatora</legend>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline model">Proizvođač</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="manufacturer" class="right-label" placeholder="Proizvođač"
                 value="${instrument_type.manufacturer}">
        </input>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline model">Naziv</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="name" class="model" placeholder="Naziv modela"
                 value="${instrument_type.name}">
        </input>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline model">Tip</label>
        </div>
        <div class="small-9 columns">
          <select name="category_id" class="select2 full-width">
            % for c in instrument_type_categories:
              <option ${'selected' if instrument_type.category_id == c.id else ''} value=${c.id}>${c.name}</option>
            % endfor
          </select>
        </div>
      </div>

    </fieldset>
    <button type="submit" class="small round button no-print">Sačuvaj</button>
    <a href="${request.route_path('home')}" class="button small round no-print">Odustani</a>

  </form>
</%def>
