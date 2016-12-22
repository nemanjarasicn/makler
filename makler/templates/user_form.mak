## -*- coding: utf-8 -*-


<%def name="user_form(user, form_action, new=False)">
<form  action="${form_action}" method="post">
  <input type="hidden" name="id" value="${user.id}" />
      <div class="row">
            <div class="small-3 columns">
                <label  class="right inline model">Korisnik</label>
            </div>
            <div class="small-9 columns">
                <input data-mesg='Možete da koristite samo velika slova, mala slova i brojeve!' type="text" title="Unesite korisnika" name="username" class="right-label" placeholder="Korisnik" pattern="[a-zA-Z0-9]+" required
                oninvalid="InvalidMsg(this);" oninput="InvalidMsg(this);"
                onchange="this.setCustomValidity('')"
                value="${user.username}"
                </input>
            </div>
      </div>

      <div class="row">
            <div class="small-3 columns">
                <label class="right inline model">Ime</label>
            </div>
            <div class="small-9 columns">
                <input data-mesg='Možete da koristite samo velika i mala slova!' type="text" title="Unesite ime" name="first_name" class="model" placeholder="Ime" required pattern="[a-zA-Z\s]+"
                 oninvalid="InvalidMsg(this);" oninput="InvalidMsg(this);"
                 onchange="this.setCustomValidity('')"
                 value="${user.first_name}">
                 </input>
            </div>
      </div>

      <div class="row">
            <div class="small-3 columns">
                <label class="right inline model">Prezime</label>
            </div>
            <div class="small-9 columns">
                <input data-mesg='Možete da unesete samo velika i mala slova!' type="text" title="Unesite prezime" name="last_name" class="model" placeholder="Prezime" required pattern="[a-zA-Z\s]+"
                oninvalid="InvalidMsg(this);" oninput="InvalidMsg(this);"
                onchange="this.setCustomValidity('')"
                value="${user.last_name}">
                </input>
            </div>
     </div>
     <div class='row'>
            <div class="small-3 columns">
                <label class="right inline model">Lozinka</label>
            </div>
            <div class="small-9 columns">
                <input data-mesg='Unesite lozinku koja ima najmanje četiri karaktera!' title='Unesite lozinku' pattern='.{4,}' type="password" ${'required' if not user.id else ''}  name="password" onchange="
                if(this.checkValidity()) form.confipass.pattern = this.value;"  oninvalid="InvalidMsg(this);" oninput="InvalidMsg(this);"
                placeholder="Unesite lozinku">
                </input>
            </div>
     </div>

    <div class="row">
        <div class="small-3 columns">
                <label class="right inline model">Potvrdi Lozinku</label>
        </div>
        <div class="small-9 columns">
            <input data-mesg='Unesite lozinku kao gore!' title="Unesite istu lozinku kao gore!" type="password" ${'required' if not user.id else ''}  name="confipass" onchange="
            this.setCustomValidity(this.validity.patternMismatch ? this.title : '');"
            placeholder="Ponovo unesite lozinku"  oninvalid="InvalidMsg(this);" oninput="InvalidMsg(this);">
            </input>
        </div>
    </div>
  <div class="row">
        <div class="small-3 columns">
            <label class="right inline model">Email</label>
        </div>
        <div class="small-9 columns">
            <input  type="text" title="Unesite email" name="email" class="model" placeholder="Email"
            value="${user.email}">
            </input>
        </div>
   </div>
   % if (not user.id or request.user.admin):
        <div class="row">
            <div class="small-3 columns">
               <label class="right inline model">admin</label>
            </div>
            <div class="small-9 columns">
                <input type="hidden" name="admin" value='False' />
                <input type="checkbox" name="admin" value='True' ${'checked' if user.admin else ''} />
            </div>
        </div>
  % endif
   <div class='small-9 columns'>
        <button type="submit" class="small round button no-print">Sačuvaj</button>
        <a href="${request.route_path('home')}" class="button small round no-print">Odustani</a>
   </div>
<script>
    function InvalidMsg(textbox) {
        if (textbox.value == '') {
    	   textbox.setCustomValidity('Polje ne sme biti prazno!');}
        else if(textbox.validity.patternMismatch){
    	    textbox.setCustomValidity(textbox.getAttribute('data-mesg'));}
        else {
    	textbox.setCustomValidity('');}
    return true;}
    </form>
</script>
</%def>
