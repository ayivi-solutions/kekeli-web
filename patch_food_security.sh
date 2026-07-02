python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

replacements = [
    ('<div class="lbl">Reforestation</div>',
     '<div class="lbl">Agriculture &amp; Food Security</div>'),
    ('Palm &amp; Coconut Reforestation</h1>',
     'Palm &amp; Coconut Cultivation</h1>'),
    ('Reforestation Site · kekeli-reforestation-dzogadze.jpg',
     'Agriculture Site · kekeli-agriculture-dzogadze.jpg'),
    ('<h4>🌱 Environmental Commitment</h4><p>Reforestation is a core part of Kekeli\'s sustainability strategy — restoring degraded land, supporting biodiversity and creating a lasting economic asset that reduces community dependence on external funding over time.</p>',
     '<h4>🌱 Food Security Commitment</h4><p>Palm plantation agriculture is a core part of Kekeli\'s sustainability strategy — strengthening local food security and creating a lasting economic asset that reduces community dependence on external funding over time.</p>'),
    ('<span>🌴 Reforestation</span><span>18%</span>',
     '<span>🌴 Agriculture &amp; Food Security</span><span>18%</span>'),
    ('<span class="chip cg">Reforestation</span>April 2025',
     '<span class="chip cg">Agriculture &amp; Food Security</span>April 2025'),
    ('<h3>Reforestation Programme Underway in Dzogadze &amp; Akeve</h3>',
     '<h3>Agriculture &amp; Food Security Programme Underway in Dzogadze &amp; Akeve</h3>'),
    ('adding cultivated acreage across both reforestation sites.',
     'adding cultivated acreage across both agriculture sites.'),
    ('Explore Reforestation →',
     'Explore Agriculture →'),
    ('onclick="filterGallery(\'reforestation\',this)">🌴 Reforestation</button>',
     'onclick="filterGallery(\'reforestation\',this)">🌴 Agriculture</button>'),
    ('<div class="gcat">Reforestation</div><div class="gname">Palm Planting, Dzogadze</div>',
     '<div class="gcat">Agriculture &amp; Food Security</div><div class="gname">Palm Planting, Dzogadze</div>'),
    ('<div class="gcat">Reforestation</div><div class="gname">Coconut Site, Akeve</div>',
     '<div class="gcat">Agriculture &amp; Food Security</div><div class="gname">Coconut Site, Akeve</div>'),
    ('<option>🌴 Reforestation</option>',
     '<option>🌴 Agriculture &amp; Food Security</option>'),
    ('<li><button onclick="go(\'work-agri\')">Reforestation</button></li>',
     '<li><button onclick="go(\'work-agri\')">Agriculture &amp; Food Security</button></li>'),
    ('<span class="chip cg">Reforestation</span><h3>Palm &amp; Coconut Planting</h3>',
     '<span class="chip cg">Agriculture &amp; Food Security</span><h3>Palm &amp; Coconut Planting</h3>'),
    ('Reforestation efforts planting palm and coconut trees in Dzogadze and Akeve — restoring ecosystems and providing lasting economic benefit.',
     'Agricultural planting of palm and coconut trees in Dzogadze and Akeve — strengthening food security and providing lasting economic benefit.'),
    ('Reforestation efforts planting palm and coconut trees in Dzogadze and Akeve — promoting environmental sustainability and economic benefit.',
     'Agricultural planting of palm and coconut trees in Dzogadze and Akeve — strengthening food security and economic benefit.'),
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
