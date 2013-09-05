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
    <script src="${request.static_url('makler:public/js/vendor/custom.modernizr.js')}"></script>
    <link rel="stylesheet" href="${request.static_url('makler:public/css/normalize.css')}">
    <link rel="stylesheet" href="${request.static_url('makler:public/css/foundation.css')}">
    <link rel="stylesheet" href="${request.static_url('makler:public/css/makler.css')}">
    <%block name="stylesheets"></%block>
  </head>

  <body>
    <div class="container">
      <img src="/public/img/header-logo.gif" id="logo" />
    <div class="row">
      <div class="large-12 columns">
        <%block name="header">
            <h1>
              ${self.title()}
            </h1>
        </%block>
      </div>
    </div>

    <div id="flash-messages" class="row">
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

    <script src="${request.static_url('makler:public/js/vendor/jquery.min.js')}"></script>
    <script src="${request.static_url('makler:public/js/foundation.min.js')}"></script>
    <%block name="javascripts"></%block>

    <script>
      $(document).foundation();
      $(document).ready(function() {
        <%block name="ready"></%block>
      });
    </script>
  </div>
  </body>
</html>

<%def name="title()">Untitled Makler</%def>
