## -*- coding: utf-8 -*-
<%inherit file="base_select2.mak"/>
<%namespace name="form" file="user_form.mak" />

<!--With this if loop we check if the entries are a new user, or edit existing -->
%if not user.id:
        <h1> Novi Korisnik </h1>

        <div class="row">
          <div class="large-6 columns">
            ${form.user_form(user, request.route_path('user_new'))}
          </div>
        </div>
%else:
    % if request.user.admin:
    <div class="row no-print">
        <div class="large-8 columns" style='right:15px;'>
          <select id="users-list" class="full-width">
            % for use in users:
            <option value="${use.id}">${use.username} &nbsp; </option>
            % endfor
          </select>
        </div>

        <div class="large-4 columns">
          <a href="${request.route_path('user_new')}" class="button small round right">novi korisnik</a>
        </div>
    % endif
        <div class="rows" >
            <h1>Korisnik: ${user.first_name} ${user.last_name}</h1>
            <div class="large-6 columns">
                ${form.user_form(user, request.route_path('user_edit', id=user.id))}
            </div>
        </div>
    </div>
%endif

<%block name="javascripts">
${parent.javascripts()}
<script src="${request.static_url('makler:public/js/home.js')}"></script>
</%block>
