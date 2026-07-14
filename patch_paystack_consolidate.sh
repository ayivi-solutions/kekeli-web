python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

old_html = '''        <div class="dform reveal reveal-delay-1" id="donateForm">
          <h3 style="font-family:'Syne',sans-serif;font-weight:700;color:var(--forest);font-size:20px;margin-bottom:18px">Choose Your Impact</h3>

          <div class="dtab-row">
            <button class="dtab on" id="tab-card" onclick="switchTab('card')">💳 Paystack</button>
            <button class="dtab" id="tab-momo" onclick="switchTab('momo')">📱 Mobile Money</button>
            <button class="dtab" id="tab-bank" onclick="switchTab('bank')">🏦 Bank Transfer</button>
          </div>

          <div id="pane-card">
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:12px">
              <input class="fin" id="d-name" type="text" placeholder="Full Name">
              <input class="fin" id="d-email" type="email" placeholder="Email Address *">
            </div>
            <div class="freq-row">
              <button class="freq-btn on" id="freq-once" onclick="setFreq('once')">One-time</button>
              <button class="freq-btn" id="freq-monthly" onclick="setFreq('monthly')">Monthly</button>
              <button class="freq-btn" id="freq-annually" onclick="setFreq('annually')">Annually</button>
            </div>
            <div class="amtg">
              <div class="amtb" onclick="selAmt(this,20)">$20</div>
              <div class="amtb" onclick="selAmt(this,50)">$50</div>
              <div class="amtb" onclick="selAmt(this,100)">$100</div>
              <div class="amtb" onclick="selAmt(this,250)">$250</div>
              <div class="amtb" onclick="selAmt(this,500)">$500</div>
              <div class="amtb" onclick="selAmt(this,'custom')">Other</div>
            </div>
            <input class="fin" id="d-custom" type="number" min="1" placeholder="Custom amount (USD)" style="display:none;margin-bottom:12px">
            <p style="font-size:11px;color:var(--slate);margin:-8px 0 14px;line-height:1.6">Amounts shown in USD for reference. Your card will be charged the GHS equivalent at the prevailing exchange rate.</p>
            <select class="fin fsel" id="d-fund">
              <option>Unrestricted — Greatest Need</option>
              <option>💧 Water Sustainability</option>
              <option>🌴 Agriculture &amp; Food Security</option>
              <option>🌾 Microfinance</option>
              <option>🎓 Community, Scholarships &amp; Health</option>
            </select>
            <div id="d-err" style="color:#c0392b;font-size:13px;margin-bottom:10px;display:none"></div>
            <button class="btn bp bfull" style="font-size:16px;padding:16px" onclick="initPaystack()">❤️ Donate Securely →</button>
            <div style="display:flex;justify-content:center;gap:14px;margin-top:12px;flex-wrap:wrap">
              <span style="font-size:11px;color:var(--slate)">🔒 SSL Encrypted</span>
              <span style="font-size:11px;color:var(--slate)">🏦 Paystack</span>
              <span style="font-size:11px;color:var(--slate)">💳 Visa / MC / Amex</span>
              <span style="font-size:11px;color:var(--slate)">📧 Receipt by email</span>
            </div>
          </div>

          <div id="pane-momo" style="display:none">
            <div class="bank-box">
              <h4>📱 Mobile Money (MTN MoMo)</h4>
              <div class="bank-row"><span class="bank-key">Merchant / Till Number</span><span class="bank-val">571852</span></div>
              <div class="bank-row"><span class="bank-key">Registered Name</span><span class="bank-val" style="font-family:inherit;font-weight:700">KEKELI CO-OPERATIVE FOR THE NEEDY</span></div>
              <div class="bank-row"><span class="bank-key">Network</span><span class="bank-val" style="font-family:inherit">MTN Mobile Money</span></div>
              <div class="bank-row"><span class="bank-key">Alternative Number</span><span class="bank-val">+233 594 972 754</span></div>
              <div class="bank-row"><span class="bank-key">Currency</span><span class="bank-val" style="font-family:inherit">GHS</span></div>
            </div>
            <div class="bank-note">
              ℹ️ <strong>To donate:</strong> Dial <strong>*170#</strong> on MTN, select Pay Bill / Merchant Payment, and enter Merchant Number <strong>571852</strong>. Confirm the name shown matches <strong>KEKELI CO-OPERATIVE FOR THE NEEDY</strong> before completing the transfer.<br><br>
              📌 After sending, please email <a href="mailto:info@kekeli4needy.com" style="color:#7a5a1a">info@kekeli4needy.com</a> with your name, amount and the MoMo transaction ID so we can acknowledge your donation promptly.
            </div>
          </div>

          <div id="pane-bank" style="display:none">
            <div class="bank-box">
              <h4>🏦 Bank Transfer Details</h4>
              <div class="bank-row"><span class="bank-key">Account Name</span><span class="bank-val" style="font-family:inherit;font-weight:700">DORGLO ANUMAH VI</span></div>
              <div class="bank-row"><span class="bank-key">Bank</span><span class="bank-val" style="font-family:inherit">GCB PLC (Ghana Commercial Bank)</span></div>
              <div class="bank-row"><span class="bank-key">Account Number</span><span class="bank-val">2181010031316</span></div>
              <div class="bank-row"><span class="bank-key">Branch</span><span class="bank-val" style="font-family:inherit">Akosombo Branch</span></div>
              <div class="bank-row"><span class="bank-key">Branch Address</span><span class="bank-val" style="font-family:inherit">Asuogyaman–Atimpoku Road, Akosombo, Eastern Region, Ghana</span></div>
              <div class="bank-row"><span class="bank-key">Bank Tel</span><span class="bank-val">+233 559 037 084</span></div>
              <div class="bank-row"><span class="bank-key">SWIFT Code</span><span class="bank-val">GHCBGHAC</span></div>
              <div class="bank-row"><span class="bank-key">Currency</span><span class="bank-val" style="font-family:inherit">USD (or GHS equivalent)</span></div>
            </div>
            <div class="bank-note">
              ℹ️ <strong>After transferring:</strong> Please email <a href="mailto:info@kekeli4needy.com" style="color:#7a5a1a">info@kekeli4needy.com</a> with your full name, amount, date of transfer and bank reference number so we can acknowledge your donation promptly.<br><br>
              📌 International transfers using SWIFT code <strong>GHCBGHAC</strong> may take 2–5 business days. Please include <strong>KEKELI DONATION</strong> in the transfer reference field.
            </div>
          </div>
'''

new_html = '''        <div class="dform reveal reveal-delay-1" id="donateForm">
          <h3 style="font-family:'Syne',sans-serif;font-weight:700;color:var(--forest);font-size:20px;margin-bottom:6px">Choose Your Impact</h3>
          <p style="font-size:12px;color:var(--slate);margin-bottom:18px">Pay by card or mobile money — processed securely through Paystack, direct to Kekeli's account. No manual transfers, no shared account numbers.</p>

          <div id="pane-card">
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:12px">
              <input class="fin" id="d-name" type="text" placeholder="Full Name">
              <input class="fin" id="d-email" type="email" placeholder="Email Address *">
            </div>
            <div class="freq-row">
              <button class="freq-btn on" id="freq-once" onclick="setFreq('once')">One-time</button>
              <button class="freq-btn" id="freq-monthly" onclick="setFreq('monthly')">Monthly</button>
              <button class="freq-btn" id="freq-annually" onclick="setFreq('annually')">Annually</button>
            </div>
            <div class="amtg">
              <div class="amtb" onclick="selAmt(this,20)">$20</div>
              <div class="amtb" onclick="selAmt(this,50)">$50</div>
              <div class="amtb" onclick="selAmt(this,100)">$100</div>
              <div class="amtb" onclick="selAmt(this,250)">$250</div>
              <div class="amtb" onclick="selAmt(this,500)">$500</div>
              <div class="amtb" onclick="selAmt(this,'custom')">Other</div>
            </div>
            <input class="fin" id="d-custom" type="number" min="1" placeholder="Custom amount (USD)" style="display:none;margin-bottom:12px">
            <p style="font-size:11px;color:var(--slate);margin:-8px 0 14px;line-height:1.6">Amounts shown in USD for reference. Your card will be charged the GHS equivalent at the prevailing exchange rate.</p>
            <select class="fin fsel" id="d-fund">
              <option>Unrestricted — Greatest Need</option>
              <option>💧 Water Sustainability</option>
              <option>🌴 Agriculture &amp; Food Security</option>
              <option>🌾 Microfinance</option>
              <option>🎓 Community, Scholarships &amp; Health</option>
            </select>
            <div id="d-err" style="color:#c0392b;font-size:13px;margin-bottom:10px;display:none"></div>
            <button class="btn bp bfull" style="font-size:16px;padding:16px" onclick="initPaystack()">❤️ Donate Securely →</button>
            <div class="card-badges">
              <span class="badge-visa">VISA</span>
              <span class="badge-mc"><span class="mc-circle mc-red"></span><span class="mc-circle mc-yellow"></span></span>
              <span class="badge-amex">AMEX</span>
              <span class="badge-momo">📱 Mobile Money</span>
            </div>
            <div style="display:flex;justify-content:center;gap:14px;margin-top:8px;flex-wrap:wrap">
              <span style="font-size:11px;color:var(--slate)">🔒 SSL Encrypted</span>
              <span style="font-size:11px;color:var(--slate)">🏦 Processed via Paystack</span>
              <span style="font-size:11px;color:var(--slate)">📧 Receipt by email</span>
            </div>
          </div>
'''

if old_html in h:
    h = h.replace(old_html, new_html)
    print("index.html: consolidated to Paystack-only")
elif 'badge-visa' in h:
    print("index.html: already consolidated — skipped")
else:
    print("index.html: WARNING — old block not found, check manually")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)

with open('css/style.css', encoding='utf-8') as f:
    c = f.read()

old_css = '.freq-row{display:flex;gap:4px;margin-bottom:20px}'
new_css = '''.freq-row{display:flex;gap:4px;margin-bottom:20px}
.card-badges{display:flex;align-items:center;justify-content:center;gap:10px;margin-top:14px;flex-wrap:wrap}
.badge-visa{background:#1A1F71;color:#fff;font-family:Arial,sans-serif;font-style:italic;font-weight:800;font-size:13px;padding:5px 10px;border-radius:4px;letter-spacing:.02em}
.badge-mc{display:inline-flex;align-items:center;background:#fff;border:1px solid var(--bdr);border-radius:4px;padding:5px 10px}
.mc-circle{width:16px;height:16px;border-radius:50%;display:inline-block}
.mc-red{background:#EB001B;margin-right:-6px;z-index:1}
.mc-yellow{background:#F79E1B;opacity:.9}
.badge-amex{background:#006FCF;color:#fff;font-family:Arial,sans-serif;font-weight:800;font-size:10.5px;padding:6px 8px;border-radius:4px;letter-spacing:.03em}
.badge-momo{background:var(--foam);color:var(--forest);font-family:'Syne',sans-serif;font-weight:700;font-size:11px;padding:6px 10px;border-radius:4px;border:1px solid rgba(46,139,87,.2)}'''

if old_css in c and '.card-badges{' not in c:
    c = c.replace(old_css, new_css)
    print("style.css: card badge CSS added")
elif '.card-badges{' in c:
    print("style.css: already added — skipped")
else:
    print("style.css: WARNING — anchor not found, check manually")

with open('css/style.css', 'w', encoding='utf-8') as f:
    f.write(c)

with open('js/main.js', encoding='utf-8') as f:
    j = f.read()

old_js = '''function switchTab(t){
  document.getElementById('tab-card').classList.toggle('on',t==='card');
  document.getElementById('tab-momo').classList.toggle('on',t==='momo');
  document.getElementById('tab-bank').classList.toggle('on',t==='bank');
  document.getElementById('pane-card').style.display=t==='card'?'block':'none';
  document.getElementById('pane-momo').style.display=t==='momo'?'block':'none';
  document.getElementById('pane-bank').style.display=t==='bank'?'block':'none';
}

'''

if old_js in j:
    j = j.replace(old_js, '')
    print("main.js: switchTab function removed")
elif 'function switchTab' not in j:
    print("main.js: already removed — skipped")
else:
    print("main.js: WARNING — exact block not found, check manually")

with open('js/main.js', 'w', encoding='utf-8') as f:
    f.write(j)
PYEOF
