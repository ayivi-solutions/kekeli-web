python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

if 'id="cf-submit"' not in h:
    h = h.replace(
        '<button class="btn bg bfull" onclick="submitContact()">Send Message →</button>',
        '<button class="btn bg bfull" id="cf-submit" onclick="submitContact()">Send Message →</button>'
    )
    with open('index.html', 'w', encoding='utf-8') as f:
        f.write(h)
    print("index.html: cf-submit id added")
else:
    print("index.html: cf-submit id already present — skipped")

with open('js/main.js', encoding='utf-8') as f:
    j = f.read()

old_js = '''function submitContact(){
  const name=document.getElementById('cf-name').value.trim();
  const email=document.getElementById('cf-email').value.trim();
  const msg=document.getElementById('cf-msg').value.trim();
  const errEl=document.getElementById('cf-err');
  const okEl=document.getElementById('cf-ok');
  errEl.style.display='none'; okEl.style.display='none';
  if(!name||!email||!msg){errEl.textContent='Please fill in your name, email and message.';errEl.style.display='block';return;}
  if(!email.includes('@')){errEl.textContent='Please enter a valid email address.';errEl.style.display='block';return;}
  // In production this integrates with WPForms or wp_mail
  okEl.style.display='block';
  document.getElementById('cf-name').value='';
  document.getElementById('cf-email').value='';
  document.getElementById('cf-org').value='';
  document.getElementById('cf-msg').value='';
}'''

new_js = '''function submitContact(){
  const name=document.getElementById('cf-name').value.trim();
  const email=document.getElementById('cf-email').value.trim();
  const org=document.getElementById('cf-org').value.trim();
  const type=document.getElementById('cf-type').value;
  const msg=document.getElementById('cf-msg').value.trim();
  const errEl=document.getElementById('cf-err');
  const okEl=document.getElementById('cf-ok');
  const btn=document.getElementById('cf-submit');
  errEl.style.display='none'; okEl.style.display='none';
  if(!name||!email||!msg){errEl.textContent='Please fill in your name, email and message.';errEl.style.display='block';return;}
  if(!email.includes('@')){errEl.textContent='Please enter a valid email address.';errEl.style.display='block';return;}

  const originalText=btn.textContent;
  btn.textContent='Sending…';
  btn.disabled=true;

  fetch('https://formspree.io/f/xwvdwlww',{
    method:'POST',
    headers:{'Accept':'application/json','Content-Type':'application/json'},
    body:JSON.stringify({name:name,email:email,organisation:org,enquiry_type:type,message:msg})
  })
  .then(res=>{
    if(res.ok){
      okEl.style.display='block';
      document.getElementById('cf-name').value='';
      document.getElementById('cf-email').value='';
      document.getElementById('cf-org').value='';
      document.getElementById('cf-type').value='';
      document.getElementById('cf-msg').value='';
    } else {
      errEl.textContent='Something went wrong sending your message. Please try again or email us directly at info@kekeli4needy.com.';
      errEl.style.display='block';
    }
  })
  .catch(()=>{
    errEl.textContent='Something went wrong sending your message. Please try again or email us directly at info@kekeli4needy.com.';
    errEl.style.display='block';
  })
  .finally(()=>{
    btn.textContent=originalText;
    btn.disabled=false;
  });
}'''

if old_js in j:
    j = j.replace(old_js, new_js)
    with open('js/main.js', 'w', encoding='utf-8') as f:
        f.write(j)
    print("main.js: contact form wired to Formspree")
elif 'formspree.io/f/xwvdwlww' in j:
    print("main.js: already wired — skipped")
else:
    print("main.js: WARNING — old submitContact not found, check manually")
PYEOF
