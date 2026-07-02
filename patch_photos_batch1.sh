python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

replacements = [
    ('<div class="tcard reveal"><div class="av avlg av1">DA</div><div class="tname">Togbe Dorglo Anumah VI</div><div class="trole">Paramount Chief of Avenor &amp; Country Director</div><div class="tbio">Paramount Chief of Avenor Traditional Area and President of the Avenor Traditional Council. Presides over borehole commissionings across Avenor land.</div></div>',
     '<div class="tcard reveal"><div class="av avlg av1" style="padding:0;overflow:hidden"><img src="images/togbe-dorglo-anumah-vi.jpg" alt="Togbe Dorglo Anumah VI" style="width:100%;height:100%;object-fit:cover;border-radius:50%"></div><div class="tname">Togbe Dorglo Anumah VI</div><div class="trole">Paramount Chief of Avenor &amp; Country Director</div><div class="tbio">Paramount Chief of Avenor Traditional Area and President of the Avenor Traditional Council. Presides over borehole commissionings across Avenor land.</div></div>'),
    ('<div class="gitem reveal reveal-delay-1" data-cat="water"><div class="ph"><div class="phi">💧</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Water</div><div class="gname">Borehole Commissioning</div></div></div>',
     '<div class="gitem reveal reveal-delay-1" data-cat="water"><div class="ph" style="padding:0;overflow:hidden"><img src="images/dzogadze-borehole.jpg" alt="Dzogadze Mechanised Borehole" style="width:100%;height:100%;object-fit:cover"></div><div class="gitem-cap"><div class="gcat">Water</div><div class="gname">Dzogadze Borehole</div></div></div>'),
    ('<div class="gitem reveal reveal-delay-3" data-cat="events"><div class="ph"><div class="phi">🎙️</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Events</div><div class="gname">Commissioning Ceremony, Gui</div></div></div>',
     '<div class="gitem reveal reveal-delay-3" data-cat="events"><div class="ph" style="padding:0;overflow:hidden"><img src="images/borehole-70th-school.jpg" alt="70th Borehole Celebration, Wovenu Senior High Technical School" style="width:100%;height:100%;object-fit:cover"></div><div class="gitem-cap"><div class="gcat">Events</div><div class="gname">70th Borehole — Wovenu SHTS</div></div></div>'),
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
