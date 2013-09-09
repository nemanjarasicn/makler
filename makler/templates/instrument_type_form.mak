## -*- coding: utf-8 -*-
<%def name="instrument_type_form(instrument_type, form_action)">
  <form action="${form_action}" method="post">
    <input type="hidden" name="id" value="${instrument_type.id}" />

    <fieldset>
      <legend>Model analizatora</legend>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Proizvođač</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="manufacturer" class="right-label" placeholder="Proizvođač"
                 value="${instrument_type.manufacturer}">
        </input>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Naziv</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="name" class="" placeholder="Naziv modela"
                 value="${instrument_type.name}">
        </input>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Tip</label>
        </div>
        <div class="small-9 columns">
          <select name="type" class="select2 full-width">
            <option ${'selected' if instrument_type.type == "biohemijski" else ''} value="biohemijski">Biohemijski</option>
            <option ${'selected' if instrument_type.type == "imunohemijski" else ''} value="imunohemijski">Imunohemijski</option>
            <option ${'selected' if instrument_type.type == "hematoloski" else ''} value="hematoloski">Hematološki</option>
            <option ${'selected' if instrument_type.type == "gasni" else ''} value="gasni">Gasni</option>
            <option ${'selected' if instrument_type.type == "hemostaticki" else ''} value="gasni">Hemostatički</option>
            <option ${'selected' if instrument_type.type == "urinski" else ''} value="urinski">Urinski</option>
          </select>
        </div>
      </div>

    </fieldset>
    <button type="submit" class="small round button">Sačuvaj</button>
    <a href="${request.route_path('home')}" class="button small round">Odustani</a>

  </form>
</%def>
