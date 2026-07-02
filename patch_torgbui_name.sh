python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

replacements = [
    ('Togbe Dorglo Anumah VI commissions the 75th borehole at Gui, Akatsi South — a landmark milestone for the Avenor Traditional Area.',
     'Torgbui Dorglo Anumah VI commissions the 75th borehole at Gui, Akatsi South — a landmark milestone for the Avenor Traditional Area.'),
    ('grew into a sustained partnership with the Avenor Traditional Council under Togbe Dorglo Anumah VI.',
     'grew into a sustained partnership with the Avenor Traditional Council under Torgbui Dorglo Anumah VI.'),
    ('<div class="tl-title">75th Borehole Commissioned · Gui</div><div class="tl-txt">Togbe Dorglo Anumah VI commissions the 75th borehole at Gui in Akatsi South — "This is the 75th borehole we are commissioning today within our Avenor land."</div>',
     '<div class="tl-title">75th Borehole Commissioned · Gui</div><div class="tl-txt">Torgbui Dorglo Anumah VI commissions the 75th borehole at Gui in Akatsi South — "This is the 75th borehole we are commissioning today within our Avenor land."</div>'),
    ('<img src="images/togbe-dorglo-anumah-vi.jpg" alt="Togbe Dorglo Anumah VI" style="width:100%;height:100%;object-fit:cover;border-radius:50%"></div><div class="tname">Togbe Dorglo Anumah VI</div>',
     '<img src="images/togbe-dorglo-anumah-vi.jpg" alt="Torgbui Dorglo Anumah VI" style="width:100%;height:100%;object-fit:cover;border-radius:50%"></div><div class="tname">Torgbui Dorglo Anumah VI</div>'),
    ('<h4>💧 Gui (Akeve-Gui) — 24 June 2026</h4><p>The 75th borehole, commissioned by Togbe Dorglo Anumah VI: "This is the 75th borehole we are commissioning today within our Avenor land."</p>',
     '<h4>💧 Gui (Akeve-Gui) — 24 June 2026</h4><p>The 75th borehole, commissioned by Torgbui Dorglo Anumah VI: "This is the 75th borehole we are commissioning today within our Avenor land."</p>'),
    ('<h3>Kekeli Commissions 75th Mechanised Borehole</h3><p>Togbe Dorglo Anumah VI commissions the 75th borehole at Gui, Akatsi South Municipality — within the Avenor Traditional Area.</p>',
     '<h3>Kekeli Commissions 75th Mechanised Borehole</h3><p>Torgbui Dorglo Anumah VI commissions the 75th borehole at Gui, Akatsi South Municipality — within the Avenor Traditional Area.</p>'),
    ('Togbe Dorglo Anumah VI, Paramount Chief of Avenor and Country Director of the Organisation, commended Brian Mosko, Director of Fundraising from Canada, and Michael "D.D." Nyahe, Director of Operations, who has personally supervised the construction and commissioning of all 75 boreholes. "This is the 75th borehole we are commissioning today within our Avenor land," Togbe Anumah said. "I appreciate the true relationship between these two partners. We can only build Avenor together."',
     'Torgbui Dorglo Anumah VI, Paramount Chief of Avenor and Country Director of the Organisation, commended Brian Mosko, Director of Fundraising from Canada, and Michael "D.D." Nyahe, Director of Operations, who has personally supervised the construction and commissioning of all 75 boreholes. "This is the 75th borehole we are commissioning today within our Avenor land," Torgbui Anumah said. "I appreciate the true relationship between these two partners. We can only build Avenor together."'),
    ('<div class="qattr">Togbe Dorglo Anumah VI · Paramount Chief of Avenor, Country Director of Kekeli</div>',
     '<div class="qattr">Torgbui Dorglo Anumah VI · Paramount Chief of Avenor, Country Director of Kekeli</div>'),
    ('<meta name="og:description" content="Clean Water · Agriculture · Community · Ghana">',
     '<meta name="og:description" content="Clean Water · Agriculture &amp; Food Security · Community · Ghana">'),
    ('<meta name="twitter:description" content="Clean Water · Agriculture · Community · Ghana">',
     '<meta name="twitter:description" content="Clean Water · Agriculture &amp; Food Security · Community · Ghana">'),
    ('<div class="hero-eyebrow"><span class="hero-eyebrow-dot"></span>Clean Water · Agriculture · Community · Ghana</div>',
     '<div class="hero-eyebrow"><span class="hero-eyebrow-dot"></span>Clean Water · Agriculture &amp; Food Security · Community · Ghana</div>'),
    ('<div class="gitem reveal reveal-delay-2" data-cat="reforestation"><div class="ph"><div class="phi">🌴</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Agriculture</div><div class="gname">Palm Planting, Dzogadze</div></div></div>',
     '<div class="gitem reveal reveal-delay-2" data-cat="reforestation"><div class="ph"><div class="phi">🌴</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Agriculture &amp; Food Security</div><div class="gname">Palm Planting, Dzogadze</div></div></div>'),
    ('<div class="gitem reveal reveal-delay-3" data-cat="reforestation"><div class="ph"><div class="phi">🥥</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Agriculture</div><div class="gname">Coconut Site, Akeve</div></div></div>',
     '<div class="gitem reveal reveal-delay-3" data-cat="reforestation"><div class="ph"><div class="phi">🥥</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Agriculture &amp; Food Security</div><div class="gname">Coconut Site, Akeve</div></div></div>'),
]

applied = 0
skipped = 0
for old, new in replacements:
    if old in h:
        h = h.replace(old, new)
        applied += 1
    else:
        skipped += 1

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)

print(f"Applied: {applied}, Already done/skipped: {skipped}")
PYEOF
