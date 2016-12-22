## base.mak
## -*- coding: utf-8 -*-

<html>
<head>
    <link rel="stylesheet" href="${request.static_url('makler:public/css/foundation.css')}" type="text/css" />
    <link rel="stylesheet" href="${request.static_url('makler:public/css/normalize.css')} " type="text/css" />
</head>
<body>
    <div class="row">
      <div>
        <form class="centered" style='margin: 0 300px;width:400px;margin-top:148px;' action="" method="post">
        <input type="hidden" name="came_from" value="${came_from}"/>

        <fieldset  id='form'>

        <legend>Prijava</legend>
        <input type="hidden" name="came_from" value="${came_from}"/>

            % if message:
                <div  style='background-color:#9a3539; border-color:#691316;' class="alert-box info radius" >
                    <span  onclick="this.parentElement.style.display='none';">&times;</span>
                    Uneli ste pogrešnog korisnika i/ili šifru
                </div>
            % endif
            <br>
            <div class="row">
              <div class="small-3 columns">
                <label class="left inline model">Korisnik</label>
              </div>
              <div class="small-9 columns">
                  <input  data-mesg='Možete da koristite samo mala slova, velika slova i brojeve' placeholder="Korisnik" class="form-control" type="text" name="login" pattern="[a-zA-Z0-9]+"  autofocus required  title="Unesite korisnika!"
                    oninvalid="InvalidMsg(this);" oninput="InvalidMsg(this);"
                   onchange="this.setCustomValidity('')"/>
              </div>
            </div>

            <div class='row'>
              <div class="small-3 columns">
                  <label class="left inline model">Lozinka</label>
              </div>
              <div class="small-9 columns">
                  <input data-mesg='Unesite lozinku koja ima najmanje četiri karaktera!' title='Unesite lozinku!'   placeholder="Lozinka" class="form-control" pattern='.{4,}' type="password" name="password"  required
                  oninvalid="InvalidMsg(this);" oninput="InvalidMsg(this);"
                   onchange="this.setCustomValidity('')"/>
              </div>
            </div>

        </fieldset>
            <button  name='submit' style='background-color:#9a3539; border-color:#691316;' type="submit" class="small round button no-print">Prijavi se</button>
          </form>
        </div>
    </div>
    </body>
</html>
<script>
    function InvalidMsg(textbox) {
        if (textbox.value == '') {
            textbox.setCustomValidity('Polje ne sme biti prazno');
        }
        else if(textbox.validity.patternMismatch){
            textbox.setCustomValidity(textbox.data-mesg);
        }
        else {
            textbox.setCustomValidity('');
        }
        return true;
    }
</script>
