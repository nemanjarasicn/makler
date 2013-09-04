## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<%def name="title()">Analizator ${instrument.name} (${instrument.institution.name})</%def>

<div class="row">
  <div class="large-6 columns">
    <form action="${request.route_path('instrument', id=instrument.id)}" method="post">
        <input type="hidden" name="id" value="${instrument.id}" />

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
        <label class="right inline">Opis</label>
      </div>
      <div class="small-9 columns">
        <textarea name="description" placeholder="Opis"></textarea>
      </div>
    </div>

    <div class="row">
        <div class="small-3 columns">
            <label class="right inline">Aktivan</label>
        </div>
        <div class="small-9 columns">
            <input type="checkbox" name="active"
                ${'checked' if instrument.active else ''}
                style="position:absolute; top:6px;" />
        </div>

    </fieldset>
    <button type="submit" class="small round">Sačuvaj</button>

    </form>
  </div>
</div>
