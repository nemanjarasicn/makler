## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<%
    institution = instrument.institution
%>

<%def name="title()">Analizator za ${instrument.institution.name}</%def>

<div class="row">
  <div class="large-6 columns">
    <form action="${request.route_path('instrument_new', id=institution.id)}" method="post">
        <input type="hidden" name="institution_id" value="${institution.id}" />

    <fieldset>
        <legend>Analizator</legend>

    <div class="row">
      <div class="small-3 columns">
        <label class="right inline">Ime</label>
      </div>
      <div class="small-9 columns">
        <input type="text" name="name" class="right-label" placeholder="ime analizatora"
              value="${instrument.name if instrument.name else ''}">
        </input>
      </div>
    </div>

    <div class="row">
      <div class="small-3 columns">
        <label class="right inline">Tip</label>
      </div>
      <div class="small-9 columns">
        <select name="type">
            <option ${'selected' if instrument.type == "biohemijski" else ''} value="biohemijski">Biohemijski</option>
            <option ${'selected' if instrument.type == "imunohemijski" else ''} value="imunohemijski">Imunohemijski</option>
            <option ${'selected' if instrument.type == "tip3" else ''} value="tip3">Tip 3</option>
            <option ${'selected' if instrument.type == "tip4" else ''} value="tip4">Tip 4</option>
        </select>
      </div>
    </div>

    <div class="row">
      <div class="small-3 columns">
        <label class="right inline">Opis</label>
      </div>
      <div class="small-9 columns">
        <input type="textarea" name="description" class="" placeholder="opis">
      </div>
    </div>

    </fieldset>
    <button type="submit" class="small round">Sačuvaj</button>

    </form>
  </div>
</div>