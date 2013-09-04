## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<div class="row">

  <div class="large-6 columns">

    <form action="${request.route_path('institution_create')}" method="post">

      <fieldset>
        <legend>Ustanova</legend>
        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Ime ustanove</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="name" class="right-label" placeholder="ime ustanove">
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Adresa</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="address" class="right-label" placeholder="adresa ustanove">
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Grad</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="city" class="right-label" placeholder="grad">
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Kontakt osoba</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="contact_person" class="right-label" placeholder="kontakt osoba">
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Telefon</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="telephone" class="right-label" placeholder="telefon">
          </div>
        </div>

        </fieldset>
        <button type="submit" class="small round">Sačuvaj</button>

    </form>

  </div>
</div>