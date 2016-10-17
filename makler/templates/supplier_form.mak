## -*- coding: utf-8 -*-

<%inherit file="base_select2.mak"/>

##  isporucilac

<h1>${contracts[0][0]} - lista ugovora</h1>
<table class="makler ugovori full-width">
    <thead>
      <tr>
        <th class="ustanova">Ustanova</th>
        <th class="text-left">Ime ugovora</th>
        <th class="text-right">Vrednost</th>
      </tr>
    </thead>
    <tbody>
      % for contract in contracts:
        <tr>
          <td>${contract[3]}</td>
          <td class="text-left">${contract[1]}</td>
          <td class="text-right">${'{:,}'.format(contract[2])}</td>
        </tr>
      % endfor
  </tbody>
