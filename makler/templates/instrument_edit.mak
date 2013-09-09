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
            <input type="text" name="name" class="right-label" placeholder="Ime analizatora"
                   value="${instrument.name}">
        </input>
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Starost</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="age" class="right-label" placeholder="Starost opreme"
                      value="${instrument.age}">
            </input>
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Broj uzoraka</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="sample_numbers" class="right-label" placeholder="Broj uzoraka"
                      value="${instrument.sample_numbers}">
            </input>
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Komentar</label>
          </div>
          <div class="small-9 columns">
            <textarea name="description" placeholder="Komentar"
                      value="${instrument.description}">
            </textarea>
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
        </div>
      </fieldset>
      <button type="submit" class="small round">Sačuvaj</button>
      <a href="${request.route_path('institution', id=instrument.institution.id)}" class="button small round">Odustani</a>

    </form>

    </div>
  </div>
