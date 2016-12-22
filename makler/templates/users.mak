## -*- coding: utf-8 -*-

<%inherit file="base_select2.mak"/>

##  korisnik

<div class="row">
  <h1 class='left'>Korisnici</h1>
 </div>
 <div>
  <a href="${request.route_path('user_new')}" class="button small round right">Novi korisnik</a>
</div>

<br>
 <table class="makler ugovori full-width">
    <thead>
      <tr>
        <th>username</th>
        <th>first name</th>
        <th>last name</th>
        <th>email</th>
     </tr>
    </thead>
     <tbody>
        % for user in users:
            <tr id="korisnik">
                <td><a href="${request.route_path('user_edit', id=user.id)}"><strong>${user.username}</strong></a></td>
                <td><a href="${request.route_path('user_edit', id=user.id)}"><strong>${user.first_name}</strong></td>
                <td><a href="${request.route_path('user_edit', id=user.id)}"><strong>${user.last_name}</strong></td>
                <td>${user.email}</td>
            </tr>
       %endfor
    </tbody>
