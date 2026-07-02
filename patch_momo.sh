python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

if 'tab-momo' not in h:
    h = h.replace(
        '''<div class="dtab-row">
            <button class="dtab on" id="tab-card" onclick="switchTab('card')">💳 Card / Online</button>
            <button class="dtab" id="tab-bank" onclick="switchTab('bank')">🏦 Bank Transfer</button>
          </div>''',
        '''<div class="dtab-row">
            <button class="dtab on" id="tab-card" onclick="switchTab('card')">💳 Card / Online</button>
            <button class="dtab" id="tab-momo" onclick="switchTab('momo')">📱 Mobile Money</button>
            <button class="dtab" id="tab-bank" onclick="switchTab('bank')">🏦 Bank Transfer</button>
          </div>'''
    )
    h = h.replace(
        '<div id="pane-bank" style="display:none">',
        '''<div id="pane-momo" style="display:none">
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

          <div id="pane-bank" style="display:none">''',
        1
    )
    with open('index.html', 'w', encoding='utf-8') as f:
        f.write(h)
    print("index.html: Mobile Money tab added")
else:
    print("index.html: Mobile Money tab already present — skipped")

with open('js/main.js', encoding='utf-8') as f:
    j = f.read()

old_js = '''function switchTab(t){
  document.getElementById('tab-card').classList.toggle('on',t==='card');
  document.getElementById('tab-bank').classList.toggle('on',t==='bank');
  document.getElementById('pane-card').style.display=t==='card'?'block':'none';
  document.getElementById('pane-bank').style.display=t==='bank'?'block':'none';
}'''

new_js = '''function switchTab(t){
  document.getElementById('tab-card').classList.toggle('on',t==='card');
  document.getElementById('tab-momo').classList.toggle('on',t==='momo');
  document.getElementById('tab-bank').classList.toggle('on',t==='bank');
  document.getElementById('pane-card').style.display=t==='card'?'block':'none';
  document.getElementById('pane-momo').style.display=t==='momo'?'block':'none';
  document.getElementById('pane-bank').style.display=t==='bank'?'block':'none';
}'''

if old_js in j:
    j = j.replace(old_js, new_js)
    with open('js/main.js', 'w', encoding='utf-8') as f:
        f.write(j)
    print("main.js: switchTab updated for Mobile Money")
elif "tab-momo" in j:
    print("main.js: already updated — skipped")
else:
    print("main.js: WARNING — old switchTab not found, check manually")
PYEOF
