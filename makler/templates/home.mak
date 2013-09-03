## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<%def name="title()">Makler DB</%def>
##<form action="${action_add_institution}" method="post">
<form>
    <div class="row">

      <div class="large-6 columns">
        <fieldset>
            <legend>Ustanova</legend>
        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Ime ustanove</label>
          </div>
          <div class="small-9 columns">
            <input type="text" class="right-label" placeholder="ime ustanove">
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Adresa</label>
          </div>
          <div class="small-9 columns">
            <input type="text" class="right-label" placeholder="adresa ustanove">
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Grad</label>
          </div>
          <div class="small-9 columns">
            <input type="text" class="right-label" placeholder="grad">
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Kontakt osoba</label>
          </div>
          <div class="small-9 columns">
            <input type="text" class="right-label" placeholder="kontakt osoba">
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Telefon</label>
          </div>
          <div class="small-9 columns">
            <input type="text" class="right-label" placeholder="telefon">
          </div>
        </div>

        </fieldset>
        <button type="submit" class="small round">Sačuvaj</button>
      </div>
  </div>

</form>


##<form action="${action_add_instrument}" method="post">
<form>
    <div class="row">

      <div class="large-6 columns">
        <fieldset>
            <legend>Analizator</legend>
        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Proizvođač</label>
          </div>
          <div class="small-9 columns">
            <input type="text" class="right-label" placeholder="ime proizvođača">
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Model</label>
          </div>
          <div class="small-9 columns">
            <input type="text" class="right-label" placeholder="model analizatora">
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Tip</label>
          </div>
          <div class="small-9 columns">
            <input type="text" class="right-label" placeholder="tip analizatora">
          </div>
        </div>

        </fieldset>
         <button type="submit" class="small round">Sačuvaj</button>
      </div>

  </div>

</form>

<div class="row">
    <h3>Ustanove</h3>
    % for institution in institutions:
        ${institution.name}
    % endfor
</div>