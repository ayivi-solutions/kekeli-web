python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

old_buttons = '''<div class="amtb" onclick="selAmt(this,230)">GHS 230<br><span style="font-size:10.5px;font-weight:400;opacity:.65">≈ $20</span></div>
              <div class="amtb" onclick="selAmt(this,575)">GHS 575<br><span style="font-size:10.5px;font-weight:400;opacity:.65">≈ $50</span></div>
              <div class="amtb" onclick="selAmt(this,1150)">GHS 1,150<br><span style="font-size:10.5px;font-weight:400;opacity:.65">≈ $100</span></div>
              <div class="amtb" onclick="selAmt(this,2875)">GHS 2,875<br><span style="font-size:10.5px;font-weight:400;opacity:.65">≈ $250</span></div>
              <div class="amtb" onclick="selAmt(this,5750)">GHS 5,750<br><span style="font-size:10.5px;font-weight:400;opacity:.65">≈ $500</span></div>
              <div class="amtb" onclick="selAmt(this,'custom')">Other</div>'''

new_buttons = '''<div class="amtb" onclick="selAmt(this,20)">$20</div>
              <div class="amtb" onclick="selAmt(this,50)">$50</div>
              <div class="amtb" onclick="selAmt(this,100)">$100</div>
              <div class="amtb" onclick="selAmt(this,250)">$250</div>
              <div class="amtb" onclick="selAmt(this,500)">$500</div>
              <div class="amtb" onclick="selAmt(this,'custom')">Other</div>'''

if old_buttons in h:
    h = h.replace(old_buttons, new_buttons)
    print("index.html: amount buttons reverted to USD")
elif '>$20</div>' in h:
    print("index.html: amount buttons already USD — skipped")
else:
    print("index.html: WARNING — GHS buttons not found, check manually")

old_input = '<input class="fin" id="d-custom" type="number" min="1" placeholder="Custom amount (GHS)" style="display:none;margin-bottom:12px">'
new_input = '''<input class="fin" id="d-custom" type="number" min="1" placeholder="Custom amount (USD)" style="display:none;margin-bottom:12px">
            <p style="font-size:11px;color:var(--slate);margin:-8px 0 14px;line-height:1.6">Amounts shown in USD for reference. Your card will be charged the GHS equivalent at the prevailing exchange rate.</p>'''

if old_input in h:
    h = h.replace(old_input, new_input)
    print("index.html: custom amount input reverted + transparency note added")
elif 'charged the GHS equivalent' in h:
    print("index.html: transparency note already present — skipped")
else:
    print("index.html: WARNING — old custom input not found, check manually")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)

with open('js/main.js', encoding='utf-8') as f:
    j = f.read()

old_js = '''/* ── PAYSTACK ──────────────────────────────────────────────────── */
const PAYSTACK_KEY = 'pk_live_2ee1be5acbb3689353d2a46ed1b7bbb14a44fe4c';

function initPaystack(){
  const customEl=document.getElementById('d-custom');
  const amount=customEl&&customEl.style.display!=='none'?parseFloat(customEl.value):selAmount;
  const email=document.getElementById('d-email').value.trim();
  const name=document.getElementById('d-name').value.trim();
  const errEl=document.getElementById('d-err');

  errEl.style.display='none';
  if(!amount||amount<1){errEl.textContent='Please select or enter a donation amount.';errEl.style.display='block';return;}
  if(!email||!email.includes('@')){errEl.textContent='Please enter a valid email address.';errEl.style.display='block';return;}

  if(!window.PaystackPop){
    alert('Payment system is loading. Please try again in a moment.');
    return;
  }

  const handler=window.PaystackPop.setup({
    key:PAYSTACK_KEY,
    email:email||'donor@kekeli4needy.com',
    amount:Math.round(amount*100),
    currency:'GHS',
    ref:'KCN-'+Date.now()+'-'+Math.floor(Math.random()*99999),
    metadata:{
      custom_fields:[
        {display_name:'Donor Name',variable_name:'donor_name',value:name||'Anonymous'},
        {display_name:'Frequency',variable_name:'frequency',value:donateFreq},
        {display_name:'Fund Allocation',variable_name:'fund',value:document.getElementById('d-fund')?document.getElementById('d-fund').value:'Unrestricted'},
        {display_name:'Organisation',variable_name:'org',value:'Kekeli Co-operative For The Needy LBG'},
      ]
    },
    callback:function(response){
      document.getElementById('donateForm').innerHTML=`
        <div style="text-align:center;padding:24px 0">
          <div style="font-size:60px;margin-bottom:20px">🎉</div>
          <h3 style="font-family:'Instrument Serif',serif;color:var(--forest);font-size:24px;margin-bottom:10px">Thank You${name?', '+name:''}!</h3>
          <p style="color:var(--slate);font-size:15px;margin-bottom:8px">Your donation of <strong style="color:var(--forest)">GHS ${amount.toLocaleString()}</strong> has been received.</p>
          <p style="color:var(--slate);font-size:13px;margin-bottom:6px">Reference: <code style="background:var(--foam);padding:2px 8px;border-radius:4px">${response.reference||response.trxref}</code></p>
          <p style="color:var(--slate);font-size:13px;margin-bottom:24px">A receipt will be sent to <strong>${email}</strong>. Kekeli will acknowledge your donation within 48 hours.</p>
          <button class="btn bg" onclick="location.reload()">Make Another Donation</button>
        </div>`;'''

new_js = '''/* ── PAYSTACK ──────────────────────────────────────────────────── */
const PAYSTACK_KEY = 'pk_live_2ee1be5acbb3689353d2a46ed1b7bbb14a44fe4c';
const USD_TO_GHS = 11.35; // update periodically to track the prevailing rate

function initPaystack(){
  const customEl=document.getElementById('d-custom');
  const amount=customEl&&customEl.style.display!=='none'?parseFloat(customEl.value):selAmount;
  const email=document.getElementById('d-email').value.trim();
  const name=document.getElementById('d-name').value.trim();
  const errEl=document.getElementById('d-err');

  errEl.style.display='none';
  if(!amount||amount<1){errEl.textContent='Please select or enter a donation amount.';errEl.style.display='block';return;}
  if(!email||!email.includes('@')){errEl.textContent='Please enter a valid email address.';errEl.style.display='block';return;}

  if(!window.PaystackPop){
    alert('Payment system is loading. Please try again in a moment.');
    return;
  }

  const ghsAmount = Math.round(amount * USD_TO_GHS);

  const handler=window.PaystackPop.setup({
    key:PAYSTACK_KEY,
    email:email||'donor@kekeli4needy.com',
    amount:Math.round(ghsAmount*100),
    currency:'GHS',
    ref:'KCN-'+Date.now()+'-'+Math.floor(Math.random()*99999),
    metadata:{
      custom_fields:[
        {display_name:'Donor Name',variable_name:'donor_name',value:name||'Anonymous'},
        {display_name:'Frequency',variable_name:'frequency',value:donateFreq},
        {display_name:'USD Amount',variable_name:'usd_amount',value:'$'+amount},
        {display_name:'Fund Allocation',variable_name:'fund',value:document.getElementById('d-fund')?document.getElementById('d-fund').value:'Unrestricted'},
        {display_name:'Organisation',variable_name:'org',value:'Kekeli Co-operative For The Needy LBG'},
      ]
    },
    callback:function(response){
      document.getElementById('donateForm').innerHTML=`
        <div style="text-align:center;padding:24px 0">
          <div style="font-size:60px;margin-bottom:20px">🎉</div>
          <h3 style="font-family:'Instrument Serif',serif;color:var(--forest);font-size:24px;margin-bottom:10px">Thank You${name?', '+name:''}!</h3>
          <p style="color:var(--slate);font-size:15px;margin-bottom:8px">Your donation of <strong style="color:var(--forest)">$${amount.toLocaleString()} USD</strong> (charged as GHS ${ghsAmount.toLocaleString()}) has been received.</p>
          <p style="color:var(--slate);font-size:13px;margin-bottom:6px">Reference: <code style="background:var(--foam);padding:2px 8px;border-radius:4px">${response.reference||response.trxref}</code></p>
          <p style="color:var(--slate);font-size:13px;margin-bottom:24px">A receipt will be sent to <strong>${email}</strong>. Kekeli will acknowledge your donation within 48 hours.</p>
          <button class="btn bg" onclick="location.reload()">Make Another Donation</button>
        </div>`;'''

if old_js in j:
    j = j.replace(old_js, new_js)
    print("main.js: USD display with GHS conversion at charge time wired in")
elif 'USD_TO_GHS' in j:
    print("main.js: already updated — skipped")
else:
    print("main.js: WARNING — old initPaystack block not found, check manually")

with open('js/main.js', 'w', encoding='utf-8') as f:
    f.write(j)
PYEOF
