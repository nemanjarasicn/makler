## -*- coding: utf-8 -*-

<%inherit file="base_select2.mak"/>

##  isporucilac
<h1>Isporučioci</h1>
 <table class="makler ugovori full-width">
    <thead>
      <tr>
        <th class="isporucilac">Isporučilac</th>
        <th class="text-right">Broj ugovora</th>
        <th class="text-right">Vrednost</th>
     </tr>
    </thead>
    <tbody>
        % for supplier in suppliers:
            <tr id="ugovor">
                <td><a href="${request.route_path('supplier_form', id=supplier[0].id)}">
                  <strong>${supplier[0].name}</strong></a>
                </td>
                <td class="text-right">${supplier[1]}</td>
                <td class="text-right">${'{:,}'.format(supplier[2])}</td>
            </tr>
       %endfor
    </tbody>
  </table>
