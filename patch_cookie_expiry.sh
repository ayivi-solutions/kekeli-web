python3 << 'PYEOF'
with open('js/main.js', encoding='utf-8') as f:
    j = f.read()

old_js = '''function cookieChoice(choice){
  try{localStorage.setItem('kekeli_cookie_consent',choice)}catch(e){}
  document.getElementById('cookieBanner').classList.remove('show');
}
function initCookieBanner(){
  let stored=null;
  try{stored=localStorage.getItem('kekeli_cookie_consent')}catch(e){}
  if(!stored){
    setTimeout(()=>document.getElementById('cookieBanner').classList.add('show'),900);
  }
}'''

new_js = '''const COOKIE_CONSENT_DAYS = 180; // re-ask after this many days

function cookieChoice(choice){
  try{
    localStorage.setItem('kekeli_cookie_consent', JSON.stringify({choice:choice, ts:Date.now()}));
  }catch(e){}
  document.getElementById('cookieBanner').classList.remove('show');
}
function initCookieBanner(){
  let expired = true;
  try{
    const raw = localStorage.getItem('kekeli_cookie_consent');
    if(raw){
      const data = JSON.parse(raw);
      const ageMs = Date.now() - (data.ts || 0);
      const maxMs = COOKIE_CONSENT_DAYS * 24 * 60 * 60 * 1000;
      expired = ageMs > maxMs;
    }
  }catch(e){}
  if(expired){
    setTimeout(()=>document.getElementById('cookieBanner').classList.add('show'),900);
  }
}'''

if old_js in j:
    j = j.replace(old_js, new_js)
    with open('js/main.js', 'w', encoding='utf-8') as f:
        f.write(j)
    print("main.js: cookie consent expiry added (180 days)")
elif 'COOKIE_CONSENT_DAYS' in j:
    print("main.js: already applied — skipped")
else:
    print("main.js: WARNING — old cookie logic not found, check manually")
PYEOF
