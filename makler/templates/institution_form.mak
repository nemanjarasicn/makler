## -*- coding: utf-8 -*-
<%def name="institution_form(institution, form_action, new=False)">
<form action="${form_action}" method="post">
  <input type="hidden" name="id" value="${institution.id}" />

    <div class="row">
      <div class="small-12 columns">

        <input type="text" name="name" class="right-label" placeholder="Ime ustanove"
               value="${institution.name}">
              </input>
        <input type="text" name="address" class="right-label" placeholder="Adresa ustanove"
               value="${institution.address}">
              </input>

        <input type="text" name="city" class="right-label" placeholder="Grad"
               value="${institution.city}">
              </input>

        <input type="text" name="phone" class="right-label" placeholder="Telefon"
               value="${institution.phone}">
              </input>

      </div>
    </div>

  <button type="submit" class="small round">Sačuvaj</button>
  <a href="${request.route_path('home')}" class="button small round">Odustani</a>
</form>

</%def>
