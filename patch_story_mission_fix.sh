python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

replacements = [
    ('🌱 Reforestation Underway in Dzogadze &amp; Akeve',
     '🌴 Agriculture &amp; Food Security Underway in Dzogadze &amp; Akeve'),
    ('and running reforestation, scholarship and community health programmes across the region. Today the Co-operative has commissioned <strong style="color:var(--forest)">75 mechanised boreholes</strong>, the most recent at Gui on 24 June 2026, serving over 250 villages, 10 schools and an estimated 130,000 people.',
     'and running agriculture, scholarship and community health programmes across the region. Today the Co-operative has commissioned <strong style="color:var(--forest)">75 mechanised boreholes</strong>, the most recent at Gui on 24 June 2026, serving over 300 villages, 10 schools and an estimated 200,000 people.'),
    ('To empower underserved communities by providing sustainable solutions for water access, agriculture and environmental conservation — offering soft loans for borehole maintenance, supporting smallholder farmers, and promoting reforestation to restore ecosystems.',
     'To empower underserved communities by providing sustainable solutions for water access, agriculture and food security — offering soft loans for borehole maintenance, supporting smallholder farmers, and promoting agriculture to strengthen local food systems.'),
]

applied = 0
notfound = []
for old, new in replacements:
    count = h.count(old)
    if count > 0:
        h = h.replace(old, new)
        applied += count
    else:
        notfound.append(old[:70])

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)

print(f"Total replacements applied: {applied}")
if notfound:
    print("WARNING - patterns not found, check manually:")
    for n in notfound:
        print("  -", n)
else:
    print("All patterns matched successfully.")
PYEOF
