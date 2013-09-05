## base.mak
## -*- coding: utf-8 -*-
<%inherit file="base.mak"/>

<%block name="stylesheets">
  <link rel="stylesheet" href="${request.static_url('makler:public/vendor/select2-3.4.2/select2.css')}">
</%block>

<%block name="javascripts">
  <script src="${request.static_url('makler:public/vendor/select2-3.4.2/select2.min.js')}"></script>
</%block>

<%block name="ready">
  $('.select2').select2();
</%block>

${next.body()}
