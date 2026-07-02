python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

old = '<button class="dtab on" id="tab-card" onclick="switchTab(\'card\')">💳 Card / Online</button>'
new = '<button class="dtab on" id="tab-card" onclick="switchTab(\'card\')">💳 Paystack</button>'

if old in h:
    h = h.replace(old, new)
    with open('index.html', 'w', encoding='utf-8') as f:
        f.write(h)
    print("index.html: tab renamed to Paystack")
elif '💳 Paystack' in h:
    print("index.html: already renamed — skipped")
else:
    print("index.html: WARNING — old tab label not found, check manually")
PYEOF
