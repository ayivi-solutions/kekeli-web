python3 << 'PYEOF'
with open('js/main.js', encoding='utf-8') as f:
    j = f.read()

old_js = '''/* ── PAYSTACK ──────────────────────────────────────────────────── */
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
        </div>`;
    },
    onClose:function(){console.log('Payment closed')}
  });
  handler.openIframe();
}'''

new_js = '''/* ── PAYSTACK ──────────────────────────────────────────────────── */
const PAYSTACK_KEY = 'pk_live_2ee1be5acbb3689353d2a46ed1b7bbb14a44fe4c';
const FALLBACK_USD_TO_GHS = 11.35; // only used if the live rate fetch fails

async function getLiveUsdToGhsRate(){
  try{
    const res = await fetch('https://open.er-api.com/v6/latest/USD');
    const data = await res.json();
    if(data && data.result==='success' && data.rates && data.rates.GHS){
      return data.rates.GHS;
    }
  }catch(e){
    console.warn('Live FX rate fetch failed, using fallback rate.', e);
  }
  return FALLBACK_USD_TO_GHS;
}

async function initPaystack(){
  const customEl=document.getElementById('d-custom');
  const amount=customEl&&customEl.style.display!=='none'?parseFloat(customEl.value):selAmount;
  const email=document.getElementById('d-email').value.trim();
  const name=document.getElementById('d-name').value.trim();
  const errEl=document.getElementById('d-err');
  const btn=document.querySelector('#pane-card .btn.bp');

  errEl.style.display='none';
  if(!amount||amount<1){errEl.textContent='Please select or enter a donation amount.';errEl.style.display='block';return;}
  if(!email||!email.includes('@')){errEl.textContent='Please enter a valid email address.';errEl.style.display='block';return;}

  if(!window.PaystackPop){
    alert('Payment system is loading. Please try again in a moment.');
    return;
  }

  const originalBtnText = btn ? btn.textContent : null;
  if(btn){btn.textContent='Getting current rate…';btn.disabled=true;}

  const liveRate = await getLiveUsdToGhsRate();
  const ghsAmount = Math.round(amount * liveRate);

  if(btn){btn.textContent=originalBtnText;btn.disabled=false;}

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
        {display_name:'FX Rate Used',variable_name:'fx_rate',value:String(liveRate)},
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
        </div>`;
    },
    onClose:function(){console.log('Payment closed')}
  });
  handler.openIframe();
}'''

if old_js in j:
    j = j.replace(old_js, new_js)
    with open('js/main.js', 'w', encoding='utf-8') as f:
        f.write(j)
    print("main.js: hardcoded FX rate replaced with live rate fetch")
elif 'getLiveUsdToGhsRate' in j:
    print("main.js: already updated — skipped")
else:
    print("main.js: WARNING — old initPaystack block not found, check manually")
PYEOF
