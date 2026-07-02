python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

replacements = [
    ('<meta name="og:description" content="Clean Water · Reforestation · Community · Ghana">',
     '<meta name="og:description" content="Clean Water · Agriculture &amp; Food Security · Community · Ghana">'),
    ('<meta name="twitter:description" content="Clean Water · Reforestation · Community · Ghana">',
     '<meta name="twitter:description" content="Clean Water · Agriculture &amp; Food Security · Community · Ghana">'),
    ('<div class="hero-eyebrow"><span class="hero-eyebrow-dot"></span>Clean Water · Reforestation · Community · Ghana</div>',
     '<div class="hero-eyebrow"><span class="hero-eyebrow-dot"></span>Clean Water · Agriculture &amp; Food Security · Community · Ghana</div>'),
    ('Reforestation Underway in Dzogadze &amp; Akeve</span>',
     'Agriculture &amp; Food Security Underway in Dzogadze &amp; Akeve</span>'),
    ('<div class="pht">Reforestation · Photo Placeholder</div>',
     '<div class="pht">Agriculture &amp; Food Security · Photo Placeholder</div>'),
    ('onclick="go(\'work-agri\')">🌴 Reforestation</button>',
     'onclick="go(\'work-agri\')">🌴 Agriculture</button>'),
    ('<div class="tl-title">Reforestation &amp; Microfinance Launched</div><div class="tl-txt">Palm and coconut reforestation begins in Dzogadze and Akeve, alongside micro-loans to Borehole Management Committees and small-holder female farmers.</div>',
     '<div class="tl-title">Agriculture &amp; Microfinance Launched</div><div class="tl-txt">Palm and coconut cultivation begins in Dzogadze and Akeve, alongside micro-loans to Borehole Management Committees and small-holder female farmers.</div>'),
    ('<p style="color:var(--slate);font-size:13px;margin-bottom:4px">All 75 boreholes sit within the Akatsi South Municipality of the Volta Region, on land under the Avenor Traditional Council.</p>',
     '<p style="color:var(--slate);font-size:13px;margin-bottom:4px">Kekeli is situated in Akatsi, the administrative capital of Akatsi South Municipal — the 75 boreholes and other projects extend across the wider Avenor Traditional Area, in the Volta Region.</p>'),
    ('<p style="color:var(--slate);font-size:11px">Over 250 villages, 10 schools and an estimated 130,000 people served. GPS coordinates for all sites are held on record.</p>',
     '<p style="color:var(--slate);font-size:11px">Over 300 villages, 10 schools and an estimated 200,000 people served. GPS coordinates for all sites are held on record.</p>'),
]

applied = 0
notfound = []
for old, new in replacements:
    count = h.count(old)
    if count > 0:
        h = h.replace(old, new)
        applied += count
    else:
        notfound.append(old[:80])

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
