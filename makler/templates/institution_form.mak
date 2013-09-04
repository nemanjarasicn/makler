## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<div class="row">

  <div class="large-6 columns">

    <form action="${form_action}" method="post">
       <input type="hidden" name="id" value="${institution.id}" />

      <fieldset>
        <legend>Ustanova</legend>
        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Ime ustanove</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="name" class="right-label" placeholder="ime ustanove"
                   value="${institution.name if institution.name else ''}">
            </input>
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Adresa</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="address" class="right-label" placeholder="adresa ustanove"
                   value="${institution.address if institution.address else ''}">
            </input>
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Grad</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="city" class="right-label" placeholder="grad"
                   value="${institution.city if institution.city else ''}">
            </input>
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Kontakt osoba</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="contact_person" class="right-label" placeholder="kontakt osoba"
                   value="${institution.contact_person if institution.contact_person else ''}">
            </input>
          </div>
        </div>

        <div class="row">
          <div class="small-3 columns">
            <label class="right inline">Telefon</label>
          </div>
          <div class="small-9 columns">
            <input type="text" name="telephone" class="right-label" placeholder="telefon"
                   value="${institution.telephone if institution.telephone else ''}">
            </input>
          </div>
        </div>

        </fieldset>
        <button type="submit" class="small round">Sačuvaj</button>

    </form>

  </div>
</div>