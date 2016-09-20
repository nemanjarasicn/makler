## -*- coding: utf-8 -*-
<%!
    from datetime import date, timedelta
%>

<%inherit file="base_select2.mak"/>
<%namespace name="form" file="institution_form.mak" />

<%def name="title()">Ustanove</%def>

<div class="row">
  <div class="large-6 columns">
    <h3>${institution.name}</h3>
    ${form.institution_form(institution, request.route_path('institution', id=institution.id))}
  </div>

  <div class="large-6 columns">

    ## Informacioni sistem
    <div class="row">
      <div class="large-12 columns">
        <h4>Laboratorijski informacioni sistem</h4>
      </div>

        <div class="large-8 columns">
          ${institution.lis.name if institution.lis else 'Nema'}
        </div>
        <div class="large-4 columns">
          <h5><a href="" class="tiny round button right" data-reveal-id="izmeni-lis">Izmeni</a></h5>
        </div>
        <div class="large-12 columns">
          <p style="border-bottom: 1px solid #ccc;"></p>
        </div>
    </div>

    ## Kontakti
    <div class="row">
      <div class="large-6 columns">
        <h4>Kontakti</h4>
      </div>

      <div class="large-6 columns no-print">
        <h5><a href="" class="tiny round button right" data-reveal-id="novi-kontakt">Dodaj</a></h5>
      </div>
    </div>

    <div class="row">
      <div class="large-12 columns">
        <table class="makler aparati full-width">
          <thead>
            <tr>
              <th>Ime i prezime</th>
              <th>Telefon</th>
              <th width="50" class="no-print">Briši</th>
            </tr>
          </thead>
          <tbody>
            % for contact in institution.contacts:
            <tr>
              <td>${contact.name}</td>
              <td>${contact.telephone}</td>
              <td class="no-print tac">
                <form action="${request.route_path('contact_delete')}" method="POST" style="display:inline">
                  <input type="hidden" name="id" value="${contact.id}" />
                  <a class="delete" type="submit"><i class="fa fa-trash-o fa-2x" aria-hidden="true"></i></a>
                </form>
              </td>
            </tr>
            % endfor
          </tbody>
        </table>
      </div>
    </div>
    ##  / Kontakti

  </div>
</div>

<div class="row">
  <div class="large-12 columns">
    <h4 style="display:inline;">Aparati</h4>
    <a href="" class="tiny round button add no-print" data-reveal-id="novi-instrument">Dodaj</a>

    <table class="makler aparati full-width">
      <thead>
        <tr>
          <th>Aktivan</th>
          <th>Proizvođač</th>
          <th>Ime analizatora</th>
          <th>Starost</th>
          <th>Broj uzoraka</th>
          <th style="min-width: 100px">Odeljenje</th>
          <th>Komentar</th>
          <th width="50" class="no-print">Briši</th>
        </tr>
      </thead>
      <tbody>
        % for instrument in instruments:
        <tr>
          <td>
            <input class="instrument-activation"
                   type="checkbox" name="${instrument.id}"
                   ${'checked' if instrument.active else ''} />
          </td>
          <td>${instrument.instrument_type.manufacturer}</td>
          <td><a href="${request.route_path('instrument', id=instrument.id)}">${instrument.instrument_type.name}</td>
          <td>${instrument.age}</td>
          <td>${instrument.sample_numbers}</td>
          <td>${instrument.department}</td>
          <td class="comment_text">${instrument.description}</td>
          <td class="no-print tac">
            <form action="${request.route_path('instrument_delete')}" method="POST" style="display:inline">
              <input type="hidden" name="id" value="${instrument.id}" />
              <a class="delete" type="submit"><i class="fa fa-trash-o fa-2x" aria-hidden="true"></i></a>
            </form>
          </td>
        </tr>
        % endfor
      </tbody>

    </table>
  </div>
</div>

<div class="row">
  <div class="large-12 columns top_px">
    ##  Ugovori
    <h4 style="display:inline;">Ugovor</h4>
      <a href="" class="tiny round button add no-print" data-reveal-id="novi-ugovor">Dodaj</a>
      <table class="makler ugovori full-width">
        <thead>
          <tr>
            <th class="contract_date" title="Objavljivanje Javne Nabavke">JN objavljena</th>
            <th class="contract_date_created">Potpisan</th>
            <th class="contract_date_until">Važi do</th>
            <th class="contract_name">Naziv ugovora</th>
            <th class="contract_description">Komentar</th>
            <th class="contract_value">Vrednost</th>
            <th class="contract_supplier">Isporučilac</th>
            <th class="no-print tac"></th>
            <th class="no-print tac"></th>
          </tr>
        </thead>
        <tbody>
          % for co in contracts:
          <tr>
            <td>${co.announced.strftime('%d.%m.%Y') if co.announced != None else None}</td>
            <td>${co.created.strftime('%d.%m.%Y') if co.created != None else None}</td>
            <td>
              % if co.valid_until != None:
                  <i class="fa ${is_valid(co.valid_until.date(),days_remain)}" aria-hidden="true"></i>
                  <span class="until">${co.valid_until.date().strftime('%d.%m.%Y')}</span>
              % endif
            </td>
            <td class="relative">
              % if co.name != None:
                <span class="col-span-2">${co.name[0:16]}</span><span class="more-fold" style="word-break: break-word;">${co.name[16:]}</span>
                % if co.name != '' and co.name != co.name[0:16]:
                  <a class="more-toggle btn expand" title="Izmena veličine prikaza"><i class="fa fa-plus fa-1x color_light_grey" aria-hidden="true"></i></a>
                % endif
              % endif
            </td>
            <td class="relative explanation comment_text">
              % if co.description != None:
                <span class="col-span-2">${co.description[0:16]}</span><span class="more-fold" style="word-break: break-word;">${co.description[16:]}</span>
                % if co.description != '' and co.description != co.description[0:16]:
                  <a class="more-toggle btn expand" title="Izmena veličine prikaza"><i class="fa fa-plus fa-1x color_light_grey" aria-hidden="true"></i></a>
                % endif
              % endif
            </td>
            <td class="value">${price(co.value)}</td>
            <td>
              % for su in suppliers:
                 % if co.supplier_id == su.id:
                   ${su.name}
                 % endif
              % endfor
            </td>
            ## Upload
            <td class="no-print tac">
              <a href="" class="round no-print" data-reveal-id="novi-dokument-${co.id}" style="display:inline" title="Dokumenti koji su vezani za ugovor">
                <i class="fa fa-file-pdf-o fa-2x" aria-hidden="true"></i>
              </a>
            </td>
            ## / Upload
            <td class="no-print tac">
              <a href="" class="round no-print" data-reveal-id="izmeni-ugovor-${co.id}" style="display:inline" title="Izmena ugovora">
                 <i class="fa fa-pencil-square-o fa-2x" aria-hidden="true"></i>
               </a>
            </td>
          </tr>
          % endfor
        </tbody>
      </table>
    ##  / Ugovori

  </div>
</div>


<%block name="modals">

  % for co in contracts:
  <div id="izmeni-ugovor-${co.id}" class="small reveal-modal no-print">
    <form action="${request.route_path('contract_edit', id=institution.id)}" method="post">
      <input type="hidden" name="institution_id" value="${institution.id}" />
      <input type="hidden" name="id" value="${co.id}" />
      <h4>Izmeni ugovor</h4>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Datum objavljivanja JN</label>
        </div>
        <div class="small-8 columns">
          <input type="text" name="announced" class="right-label" placeholder="dd.mm.yyyy" required
                 value="${co.announced.strftime('%d.%m.%Y') if co.announced != None else None}"
                 pattern="[0-3][0-9].[0-1][0-9].(19|20)\d{2}"
                 title="Unesite datum u formatu dd.mm.yyyy (e.g. 22.07.2011)" />
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Datum potpisivanja JN</label>
        </div>
        <div class="small-8 columns">
          <input type="text" name="created" class="right-label" placeholder="dd.mm.yyyy" required
                 value="${co.created.strftime('%d.%m.%Y') if co.created != None else None}"
                 pattern="[0-3][0-9].[0-1][0-9].(19|20)\d{2}"
                 title="Unesite datum u formatu dd.mm.yyyy (e.g. 22.07.2011)" />
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Ugovor važi do</label>
        </div>
        <div class="small-8 columns">
          <input type="text" name="valid_until" class="right-label" placeholder="dd.mm.yyyy" required
                 value="${co.valid_until.strftime('%d.%m.%Y') if co.valid_until != None else None}"
                 pattern="[0-3][0-9].[0-1][0-9].(19|20)\d{2}"
                 title="Unesite datum u formatu dd.mm.yyyy (e.g. 22.07.2011)" />
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Naziv ugovora</label>
        </div>
        <div class="small-8 columns">
          <textarea name="name" placeholder="Naziv ugovora" style="word-break:break-all;">${co.name}</textarea>
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Komentar</label>
        </div>
        <div class="small-8 columns">
          <textarea name="description" placeholder="Komentar" style="word-break:break-all;">${co.description}</textarea>
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Vrednost</label>
        </div>
        <div class="small-8 columns">
          <input type="text" name="value" class="right-label" placeholder="Vrednost" value="${dec_num(co.value)}"
                 pattern="^[0-9]*\.?[0-9]*"  title="Samo cifre i tačka mogu biti unete" required/>
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Isporučilac</label>
        </div>
        <div class="small-8 columns">
          <select name="supplier_id" class="full-width form-control supplier_list">
            <option></option>
            % for su in suppliers:
              % if co.supplier_id == su.id:
                <option value="${su.id}" selected>${su.name}</option>
              % else:
                <option value="${su.id}">${su.name}</option>
              % endif
            % endfor
          </select>
        </div>
      </div>
      <button class="small round button" type="submit">Izmeni</button>
      <a class="small round cancel button">Odustani</a>
      <a href="" class="small round button right" style="right:20px;"data-reveal-id="novi-isporucilac" title="Unesi naziv novog isporučioca">Dodaj isporučioca</a>
    </form>
    <a class="close-reveal-modal">&#215;</a>
  </div>
  % endfor

  % for co in contracts:
    <div id="novi-dokument-${co.id}" class="small reveal-modal no-print">
      <h4>${co.name}</h4>

      <table class="makler ugovori full-width">
        <thead>
          <tr>
            <th class="w65">Naziv Dokumenta</th>
            <th>Datum postavljanja</th>
            <th>Preuzmi</th>
          </tr>
        </thead>
        <tbody>
          % for doc in co.documents:
          <tr>
            <td>${doc.original_name}</td>
            <td>${doc.upload_date.strftime('%d.%m.%Y') if doc.upload_date != None else None}</td>
            <td style="margin: 8px 0; display: block; text-align: center;">
              <a href="${request.route_path('document_download', id=doc.id)}">
                <i class="fa fa-download fa-2x" aria-hidden="true"></i>
              </a>
            </td>

          </tr>
          % endfor
        </tbody>
      </table>

      <form action="${request.route_path('document_upload')}" method="post" accept-charset="utf-8" enctype="multipart/form-data">
          <h4 class="top_px">Dodaj dokument</h4>
          <input type="text" size="40" class="file_input_replacement" placeholder="Izaberi dokument" />
          <input type="file" class="file_input_with_replacement" name="document"/>
          <input type="text" name="coid" value="${co.id}" style="display: none;" />
          <input class="small round button float_right" type="submit" value="Potvrdi" />
      </form>

      <a class="close-reveal-modal">&#215;</a>

    </div>
  % endfor

  <div id="novi-ugovor" class="small reveal-modal no-print">
    <form action="${request.route_path('contract_new', id=institution.id)}" method="post">
      <input type="hidden" name="institution_id" value="${institution.id}" />
      <h4>Dodaj novi ugovor</h4>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Datum objavljivanja JN</label>
        </div>
        <div class="small-8 columns">
          <input type="text" name="announced" class="right-label" placeholder="dd.mm.yyyy" required
                 pattern="[0-3][0-9].[0-1][0-9].(19|20)\d{2}"
                 title="Unesite datum u formatu dd.mm.yyyy (e.g. 22.07.2011)" />
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Datum potpisivanja JN</label>
        </div>
        <div class="small-8 columns">
          <input type="text" name="created" class="right-label" placeholder="dd.mm.yyyy" required
                 pattern="[0-3][0-9].[0-1][0-9].(19|20)\d{2}"
                 title="Unesite datum u formatu dd.mm.yyyy (e.g. 22.07.2011)" />
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Ugovor važi do</label>
        </div>
        <div class="small-8 columns">
          <input type="text" name="valid_until" class="right-label" placeholder="dd.mm.yyyy" required
                 pattern="[0-3][0-9].[0-1][0-9].(19|20)\d{2}"
                 title="Unesite datum u formatu dd.mm.yyyy (e.g. 22.07.2011)" />
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Naziv ugovora</label>
        </div>
        <div class="small-8 columns">
          <textarea name="name" placeholder="Naziv ugovora" style="word-break:break-all;"></textarea>
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Komentar</label>
        </div>
        <div class="small-8 columns">
          <textarea name="description" placeholder="Komentar" style="word-break:break-all;"></textarea>
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Vrednost</label>
        </div>
        <div class="small-8 columns">
          <input type="text" name="value" class="right-label" placeholder="Vrednost"
                 pattern="^[0-9]*\.?[0-9]*" title="Samo cifre i tačka mogu biti unete" required/>
        </div>
      </div>

      <div class="row">
        <div class="small-4 columns">
          <label class="right inline">Isporučilac</label>
        </div>
        <div class="small-8 columns">
          <select name="supplier_id" class="full-width supplier_list">
            <option></option>
            % for sup in suppliers:
              % if supplier_id == sup.id:
                <option value="${sup.id}" selected>${sup.name}</option>
              % else:
                <option value="${sup.id}">${sup.name}</option>
              % endif
            % endfor
          </select>
        </div>
      </div>
      <button class="small round button" type="submit">Dodaj</button>
      <a class="small round cancel button">Odustani</a>
      <a href="" class="small round button right" style="right:20px;" data-reveal-id="novi-isporucilac" title="Unesi naziv novog isporučioca">Dodaj isporučioca</a>
    </form>
    <a class="close-reveal-modal">&#215;</a>
  </div>

<div id="novi-instrument" class="small reveal-modal no-print">
    <form action="${request.route_path('instrument_new', id=institution.id)}" method="post">
      <input type="hidden" name="institution_id" value="${institution.id}" />
      <h4>Dodaj novi aparat</h4>

      <div class="row" style="margin-bottom: 10px;">
        <div class="large-12 columns">
          <select id="instrument-types-list" name="instrument_type_id" class="full-width">
            <option></option>
            % for instrument_type in instrument_types:
            <option value="${instrument_type.id}">${instrument_type.name}</option>
            % endfor
          </select>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Odeljenje</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="department" class="right-label" placeholder="Odeljenje" />
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Starost</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="age" class="right-label" placeholder="Starost opreme" />
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Broj uzoraka</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="sample_numbers" class="right-label" placeholder="Broj uzoraka" />
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Komentar</label>
        </div>
        <div class="small-9 columns">
          <textarea name="description" placeholder="Komentar" style="word-break:break-all;"></textarea>
        </div>
      </div>

      <div class="row">
        <div class="small-3 columns">
          <label class="right inline">Aktivan</label>
        </div>
        <div class="small-9 columns">
          <input type="checkbox" value="1" name="active" style="position:absolute; top:6px;" />
        </div>
      </div>
    <button class="small round button disabled" type="submit" style="margin-top:10px;">Dodaj</button>
    <a class="small round cancel button">Odustani</a>
    </form>
    <a class="close-reveal-modal">&#215;</a>
  </div>

  <div id="novi-kontakt" class="small reveal-modal no-print">
    <div class="row">
      <div class="large-12 columns">
        <h4>Dodaj novi kontakt</h4>
      </div>
    </div>

    <div class="row">
      <form action="${request.route_path('contact_new', id=institution.id)}" method="POST" style="display:inline;">
        <div class="large-6 columns">
          <input type="hidden" name="institution_id" value="${institution.id}" />
          <input type="text" name="name" placeholder="Ime i prezime" />
        </div>
        <div class="large-6 columns">
          <input type="text" name="telephone" placeholder="Broj telefona" />
        </div>
    </div>

    <div class="row">
      <div class="large-12 columns">
        <button type="submit" class="small round button">Dodaj</button>
        <a class="small round cancel button">Odustani</a>
      </div>
      </form>
    </div>

    <a class="close-reveal-modal">&#215;</a>
  </div>

  <div id="izmeni-lis" class="small reveal-modal no-print">
    <div class="row">
      <div class="large-12 columns">
        <h4>Izaberi lab. informacioni sistem</h4>
      </div>
    </div>

    <div class="row">
      <div class="large-12 columns">
        <form action="${request.route_path('lis_edit', id=institution.id)}" method="POST" style="display:inline;">
          <input type="hidden" name="institution_id" value="${institution.id}" />

          <select id="lis_list" name="lis_id" class="full-width">
          <option></option>
          % for i in lis:
            <option value="${i.id}">${i.name}</option>
          % endfor
          </select>

          <button type="submit" class="small round button" style="margin-top:20px;">Sačuvaj</button>
          <a class="small round cancel button" style="margin-top:20px;">Odustani</a>
          <a class="small round button right" data-reveal-id="novi-lis" style="margin-top:20px;">Dodaj novi</a>
        </form>
      </div>
    </div><a class="close-reveal-modal">&#215;</a>
  </div>

  <div id="novi-lis" class="small reveal-modal reveal-padding">
    <div class="row">
      <div class="large-12 columns">
        <h4>Dodaj novi laboratorijski informacioni sistem</h4>
      </div>
    </div>
    <div class="row">
      <div class="large-12 columns">
        <form action="${request.route_path('lis_new')}" method="POST" class="margin_add_new">
          <input type="text" name="name" placeholder="Unesite naziv lab informacionog sistema" />
          <button type="submit" class="small round button margin_add_new">Sačuvaj</button>
          <a class="small round cancel button margin_add_new">Odustani</a>

        </form>
      </div>
    </div>
  <a class="close-reveal-modal">&#215;</a>
  </div>

  <div id="novi-isporucilac" class="small reveal-modal reveal-padding">
  <div class="row">
    <div class="large-12 columns">
      <h4>Dodaj novog isporučioca</h4>
    </div>
  </div>
    <div class="row">
      <div class="large-12 columns">
        <form action="${request.route_path('supplier_new')}" method="POST" class="margin_add_new">
          <input type="text" name="name" placeholder="Unesite naziv novog isporučioca" />
          <button type="submit" class="small round button margin_add_new">Sačuvaj</button>
          <a class="small round cancel button margin_add_new">Odustani</a>
        </form>
      </div>
    </div>
    <a class="close-reveal-modal">&#215;</a>
  </div>

</%block>

<%block name="javascripts">
${parent.javascripts()}
<script src="${request.static_url('makler:public/js/institution_edit.js')}"></script>

</%block>

<%def name="is_valid(until, days_remain)">
<%
    today = date.today()
    if until - timedelta(days=days_remain) < today and until > today:
        return "fa-exclamation-triangle color_yellow"
    elif until > today:
        return "fa-circle color_green"
    elif until < today:
        return "fa-ban color_grey"
    else:
        return "fa-exclamation-triangle color_red"
%>
</%def>

<%def name="price(cost)">
<%
    worth = str(cost)
    worth = str(worth[:-8])
    worth = '{:,.2f}'.format(cost)
    return worth
%>
</%def>

<%def name="dec_num(number)">
<%
    number = str(number)
    number = number[:-8]
    return number
%>
</%def>
