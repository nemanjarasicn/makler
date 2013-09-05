## -*- coding: utf-8 -*-
<%def name="institution_form(institution, form_action)">
  <form action="${form_action}" method="post">
    <input type="hidden" name="id" value="${institution.id}" />

    <fieldset>
      <legend>Ustanova</legend>
      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Ime ustanove</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="name" class="right-label" placeholder="Ime ustanove"
                 value="${institution.name}">
              </input>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Adresa</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="address" class="right-label" placeholder="Adresa ustanove"
                 value="${institution.address}">
              </input>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Grad</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="city" class="right-label" placeholder="Grad"
                 value="${institution.city}">
              </input>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Telefon</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="phone" class="right-label" placeholder="Telefon"
                 value="${institution.phone}">
              </input>
        </div>
      </div>

      <h6>Kontakti</h6>
      % for contact in institution.contacts:
      <div class="row">
        <div class="large-3 large-offset-3 columns">
          ${contact.name}
        </div>
        <div class="large-3 columns">
          ${contact.telephone}
        </div>
        <div class="large-1 large-offset-2 columns">
          <input type="button" class="delete" data-id="${contact.id}" style="display:inline; position:relative; top: 4px;" />
        </div>
      </div>
      % endfor

    </fieldset>
    <button type="submit" class="small round">Sačuvaj</button>
    <a href="${request.route_path('home')}" class="button small round">Odustani</a>
  </form>
</%def>
