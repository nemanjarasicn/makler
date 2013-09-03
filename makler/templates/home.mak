## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<%def name="title()">Makler DB</%def>

<div class="row">
  <div class="large-6 columns">
    <h3>Ustanove</h3>
      <ul>
        <a href="${request.route_path('home', id='new')}"><li>Dodaj novu</li></a>
        % for institution in institutions:
            <a href="${request.route_path('home', id=institution.id)}"><li>${institution.name}</li></a>
        % endfor
      </ul>
  </div>

  <div class="large-6 columns">

    <form action="${action_add_institution}" method="post">

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
      </div>
  </div>

</form>


<form action="${action_add_instrument}" method="post">

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
