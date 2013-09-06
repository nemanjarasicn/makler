## -*- coding: utf-8 -*-
<%def name="institution_form(institution, form_action, new=False)">
<form action="${form_action}" method="post">
  <input type="hidden" name="id" value="${institution.id}" />

  <fieldset>
    <legend>Osnovno</legend>

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
  </fieldset>

  % if not new:
  <fieldset>
    <legend>
      Kontakti
      <a href="" class="tiny round" data-reveal-id="novi-kontakt">+</a>
    </legend>

    % for contact in institution.contacts:
    <div class="row">
      <div class="large-3 large-offset-3 columns kontakti">
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

  <fieldset>
    <legend>
      Aparati
      <a href="" class="tiny round " data-reveal-id="novi-instrument">+</a>
    </legend>
    <div class="row">
      <div class="large-6 columns">
        <ul>
          % for instrument in instruments:
          <li>
            <input class="instrument-activation"
                   type="checkbox" name="${instrument.id}"
                   ${'checked' if instrument.active else ''} />
            <a class="instrument" data-id="${instrument.id}"
               href="${request.route_path('instrument', id=instrument.id)}">
              ${instrument.instrument_type.manufacturer} ${instrument.instrument_type.name} ${instrument.description}
            </a>
            <form action="${request.route_path('instrument_delete')}" method="POST" style="display:inline">
              <input type="hidden" name="id" value="${instrument.id}" />
              <button class="delete" type="submit"></button>
            </form>
          </li>
          % endfor
        </ul>
      </div>
    </div>
  </fieldset>

  % endif

  <button type="submit" class="small round">Sačuvaj</button>
  <a href="${request.route_path('home')}" class="button small round">Odustani</a>
</form>

</%def>
