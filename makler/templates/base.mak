## base.mak
## -*- coding: utf-8 -*-

<%
    flash = ' '.join(request.session.pop_flash())
%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>${self.title()}</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">
    <link rel="shortcut icon" type="image/x-icon" href="/public/img/favicon.ico?v5" />
    <script src="${request.static_url('makler:public/js/vendor/custom.modernizr.js')}"></script>
    <link rel="stylesheet" href="${request.static_url('makler:public/css/normalize.css')} " type="text/css" />
    <link rel="stylesheet" href="${request.static_url('makler:public/css/foundation.css')}" type="text/css" />
    <link rel="stylesheet" href="${request.static_url('makler:public/css/print.css')}" type="text/css" media="print" />
    <link rel="stylesheet" href="${request.static_url('makler:public/css/font-awesome.css')}" />
    <link rel="stylesheet" href="${request.static_url('makler:public/css/makler.css')}" type="text/css" media="screen" />


  </head>
  <body>

      <div style='display:inline;'>
          <a id="logout" href="/logout" class="small button round right" id="logout" title="logout">
            logout
          </a>
          <a  href="${request.route_path('user_edit', id=request.user.id)}" class=" small button round right"  title="korisnik"><i class="fa fa-cog "></i>
          </a>
       </div>


    <div class="row header no-print">
      <a  id="izvestaj" class="small round right- button" data-dropdown="drop" style="float:right;">izveštaji &raquo;</a>
      <ul id="drop" class="small f-dropdown" data-dropdown-content>
        <li><a href="/reports">instalirani aparati</a></li>
        <li><a href="/suppliers">isporučioci</a></li>
      </ul>

      <a id="unos_apa" href="/instruments" class="small button round right" id="aparati" title="unos novog aparata">
        novi model
      </a>
      <a href="/"><img src="/public/img/header-logo.gif" id="logo" /></a>
    </div>

     <div class="page">
      <div class="row">
        <div class="large-12 columns">
          <%block name="header"><h1>${self.title()}</h1></%block>
        </div>

      </div>

      <div id="flash-messages" class="row no-print">
        <div class="large-12 columns">
          % if flash:
          <div data-alert id="flash-message" class="alert-box ${'alert' if errors else ''} radius">
            ${flash}
            <a href="#" class="close">&times;</a>
          </div>
          % endif
        </div>
      </div>

      <div class="row">
        <div class="large-12 columns">
          ${next.body()}
        </div>
      </div>
    </div>

    <%block name="modals"></%block>

    <script src="${request.static_url('makler:public/js/vendor/jquery.min.js')}"></script>
    <script src="${request.static_url('makler:public/js/vendor/foundation.min.js')}"></script>
    <%block name="javascripts"></%block>

    <script>
      $(document).foundation();
      $(document).ready(function() {
      <%block name="ready"></%block>
      });
    </script>
  </body>
</html>

<%def name="title()"></%def>
