## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<%def name="title()">Novi model analizatora</%def>

<div class="row">
  <div class="large-6 columns">
    <form action="${request.route_path('instrument_type_new')}" method="post">
        <input type="hidden" name="id" value="${instrument_type.id}" />

    <fieldset>
        <legend>Model analizatora</legend>

    <div class="row">
      <div class="small-3 columns">
        <label class="right inline">Proizvođač</label>
      </div>
      <div class="small-9 columns">
        <input type="text" name="manufacturer" class="right-label" placeholder="Proizvođač"
              value="${instrument_type.name if instrument_type.name else ''}">
        </input>
      </div>
    </div>

    <div class="row">
      <div class="small-3 columns">
        <label class="right inline">Naziv</label>
      </div>
      <div class="small-9 columns">
        <input type="text" name="name" class="" placeholder="Naziv modela">
      </div>
    </div>

    <div class="row">
      <div class="small-3 columns">
        <label class="right inline">Tip</label>
      </div>
      <div class="small-9 columns">
        <select name="type">
          <option ${'selected' if instrument_type.type == "biohemijski" else ''} value="biohemijski">Biohemijski</option>
          <option ${'selected' if instrument_type.type == "imunohemijski" else ''} value="imunohemijski">Imunohemijski</option>
          <option ${'selected' if instrument_type.type == "hematoloski" else ''} value="hematoloski">Hematološki</option>
        </select>
      </div>
    </div>

    </fieldset>
    <button type="submit" class="small round">Sačuvaj</button>

    </form>
  </div>
</div>
