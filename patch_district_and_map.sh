python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

replacements = [
    ('<div class="ti"><span class="ti-dot"></span>District Assembly Partnerships</div>',
     '<div class="ti"><span class="ti-dot"></span>Municipal Assembly Partnerships</div>'),

    ('<div class="qattr">Community Leader · Akatsi South District, Volta Region</div>',
     '<div class="qattr">Community Leader · Akatsi South Municipal, Volta Region</div>'),

    ('<div class="qattr">District Water &amp; Sanitation Officer · Volta Region</div>',
     '<div class="qattr">Municipal Water &amp; Sanitation Officer · Volta Region</div>'),

    ('<div class="plogo"><span>🏛️</span>Akatsi South District Assembly</div>',
     '<div class="plogo"><span>🏛️</span>Akatsi South Municipal Assembly</div>'),

    ('<div class="ocrd reveal reveal-delay-2"><div style="font-size:28px">🏛️</div><h4>Government &amp; Assembly</h4><p>District Assembly collaboration for jointly-funded water infrastructure, community development and WASH programming.</p></div>',
     '<div class="ocrd reveal reveal-delay-2"><div style="font-size:28px">🏛️</div><h4>Government &amp; Assembly</h4><p>Municipal Assembly collaboration for jointly-funded water infrastructure, community development and WASH programming.</p></div>'),

    ('<h3>District Assembly Signs MOU with Kekeli</h3><p>Akatsi South District Assembly formalises a partnership for jointly-funded water infrastructure delivery.</p>',
     '<h3>Municipal Assembly Signs MOU with Kekeli</h3><p>Akatsi South Municipal Assembly formalises a partnership for jointly-funded water infrastructure delivery.</p>'),

    ('<div class="csub">Akatsi South District, Volta Region<br>Ghana, West Africa</div>',
     '<div class="csub">Akatsi South Municipal, Volta Region<br>Ghana, West Africa</div>'),

    ('<div class="reveal" style="background:linear-gradient(135deg,var(--foam),var(--mist));border-radius:16px;padding:20px;border:1px solid rgba(46,139,87,.15);font-size:13.5px;color:var(--slate)">🗺️ <strong style="color:var(--forest)">Map:</strong> Interactive Google Map showing Akatsi South District, Volta Region will be embedded in production.</div>',
     '<div class="reveal" style="border-radius:16px;overflow:hidden;border:1px solid rgba(46,139,87,.15)"><iframe src="https://www.google.com/maps?q=Akatsi,+Volta+Region,+Ghana&output=embed" width="100%" height="280" style="border:0;display:block" allowfullscreen loading="lazy" referrerpolicy="no-referrer-when-downgrade" title="Map of Akatsi, Volta Region, Ghana"></iframe></div>'),

    ('Our registered address is Akatsi South District, Volta Region, Ghana.',
     'Our registered address is Akatsi South Municipal, Volta Region, Ghana.'),
]

applied = 0
skipped = 0
notfound = []
for old, new in replacements:
    if new in h:
        skipped += 1
    elif old in h:
        h = h.replace(old, new)
        applied += 1
    else:
        notfound.append(old[:70])

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)

print(f"Applied: {applied}, Already done: {skipped}")
if notfound:
    print("WARNING - genuinely not found, check manually:")
    for n in notfound:
        print("  -", n)
PYEOF
