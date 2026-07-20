python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

replacements = [
    ('<div class="ph pher reveal"><div class="phi">🌴</div><div class="pht">Agriculture Site · kekeli-agriculture-dzogadze.jpg</div></div>',
     '<div class="ph pher reveal" style="padding:0;overflow:hidden"><img src="public/images/kekeli-work-agriculture.jpg" alt="Agriculture site, Dzogadze" style="width:100%;height:100%;object-fit:cover;cursor:pointer" onclick="openLightbox(this.src,this.alt)"></div>'),

    ('<div class="ph phlg"><div class="phi">🍊</div><div class="pht">Orchard Photo · Placeholder</div></div>',
     '<div class="ph phlg" style="padding:0;overflow:hidden"><img src="public/images/kekeli-gallery-orchard-volta-school.jpg" alt="Orchard at Volta School for the Deaf" style="width:100%;height:100%;object-fit:cover;cursor:pointer" onclick="event.stopPropagation();openLightbox(this.src,this.alt)"></div>'),

    ('<div class="ph phlg"><div class="phi">🐔</div><div class="pht">Poultry Farm Photo · Placeholder</div></div>',
     '<div class="ph phlg" style="padding:0;overflow:hidden"><img src="public/images/kekeli-gallery-poultry-volta-school.jpg" alt="Poultry farm at Volta School for the Deaf" style="width:100%;height:100%;object-fit:cover;cursor:pointer" onclick="event.stopPropagation();openLightbox(this.src,this.alt)"></div>'),

    ('<div class="card reveal"><div class="cb"><div style="font-size:32px;margin-bottom:10px">🎓</div><h3>Scholarships</h3><p>Scholarships awarded to deserving students from rural communities, enabling them to pursue their educational goals.</p></div></div>',
     '<div class="card reveal"><div class="ph" style="height:140px;padding:0;overflow:hidden"><img src="public/images/kekeli-work-scholarships.jpg" alt="Scholarships for rural students" style="width:100%;height:100%;object-fit:cover;cursor:pointer" onclick="openLightbox(this.src,this.alt)"></div><div class="cb"><div style="font-size:32px;margin-bottom:10px">🎓</div><h3>Scholarships</h3><p>Scholarships awarded to deserving students from rural communities, enabling them to pursue their educational goals.</p></div></div>'),

    ('<div class="card reveal reveal-delay-1"><div class="cb"><div style="font-size:32px;margin-bottom:10px">💊</div><h3>Malaria Testing &amp; Antibiotics</h3><p>250 rounds of antibiotics provided for those testing positive for malaria, alongside annual community testing clinics purchased through a local hospital in Akatsi.</p></div></div>',
     '<div class="card reveal reveal-delay-1"><div class="ph" style="height:140px;padding:0;overflow:hidden"><img src="public/images/kekeli-work-health.jpg" alt="Malaria testing and antibiotic distribution" style="width:100%;height:100%;object-fit:cover;cursor:pointer" onclick="openLightbox(this.src,this.alt)"></div><div class="cb"><div style="font-size:32px;margin-bottom:10px">💊</div><h3>Malaria Testing &amp; Antibiotics</h3><p>250 rounds of antibiotics provided for those testing positive for malaria, alongside annual community testing clinics purchased through a local hospital in Akatsi.</p></div></div>'),

    ('<div class="card reveal reveal-delay-2"><div class="cb"><div style="font-size:32px;margin-bottom:10px">🏥</div><h3>Dzogadze Medical Clinic</h3><p>A renovated walk-in medical clinic in Dzogadze, piped directly from the community borehole for clean water access on site.</p></div></div>',
     '<div class="card reveal reveal-delay-2"><div class="ph" style="height:140px;padding:0;overflow:hidden"><img src="public/images/kekeli-gallery-clinic-dzogadze.jpg" alt="Dzogadze medical clinic" style="width:100%;height:100%;object-fit:cover;cursor:pointer" onclick="openLightbox(this.src,this.alt)"></div><div class="cb"><div style="font-size:32px;margin-bottom:10px">🏥</div><h3>Dzogadze Medical Clinic</h3><p>A renovated walk-in medical clinic in Dzogadze, piped directly from the community borehole for clean water access on site.</p></div></div>'),

    ('<div class="ph pher reveal" style="margin-bottom:28px"><div class="phi">🍊🍍🌴</div><div class="pht">Orchard Site · kekeli-orchard-volta-school-deaf.jpg</div></div>',
     '<div class="ph pher reveal" style="margin-bottom:28px;padding:0;overflow:hidden"><img src="public/images/kekeli-gallery-orchard-volta-school.jpg" alt="Orchard at Volta School for the Deaf" style="width:100%;height:100%;object-fit:cover;cursor:pointer" onclick="openLightbox(this.src,this.alt)"></div>'),

    ('<div class="ph pher reveal" style="margin-bottom:28px"><div class="phi">🐔</div><div class="pht">Poultry Farm · kekeli-poultry-volta-school-deaf.jpg</div></div>',
     '<div class="ph pher reveal" style="margin-bottom:28px;padding:0;overflow:hidden"><img src="public/images/kekeli-gallery-poultry-volta-school.jpg" alt="Poultry farm at Volta School for the Deaf" style="width:100%;height:100%;object-fit:cover;cursor:pointer" onclick="openLightbox(this.src,this.alt)"></div>'),

    ('<div class="ph pher reveal" style="margin-bottom:26px"><div class="phi">💧</div><div class="pht">Commissioning Ceremony, Gui · kekeli-borehole-75-gui.jpg</div></div>',
     '<div class="ph pher reveal" style="margin-bottom:26px;padding:0;overflow:hidden"><img src="public/images/gui-75th-borehole-names.jpg" alt="75th Borehole commissioning ceremony, Gui" style="width:100%;height:100%;object-fit:cover;cursor:pointer" onclick="openLightbox(this.src,this.alt)"></div>'),

    ('<div class="ph pher reveal" style="margin-bottom:26px"><div class="phi">🏫🍊🐔</div><div class="pht">School Programme Photo · Placeholder</div></div>',
     '<div class="ph pher reveal" style="margin-bottom:26px;padding:0;overflow:hidden"><img src="public/images/kekeli-gallery-orchard-volta-school.jpg" alt="Orchard and poultry programmes at Volta School for the Deaf" style="width:100%;height:100%;object-fit:cover;cursor:pointer" onclick="openLightbox(this.src,this.alt)"></div>'),

    ('<div class="card reveal" onclick="go(\'n1\')"><div class="ph"><div class="phi">💧</div></div>',
     '<div class="card reveal" onclick="go(\'n1\')"><div class="ph" style="padding:0;overflow:hidden"><img src="public/images/gui-75th-borehole-names.jpg" alt="75th Borehole, Gui" style="width:100%;height:100%;object-fit:cover"></div>'),

    ('<div class="card reveal reveal-delay-1" onclick="go(\'n2\')"><div class="ph"><div class="phi">🏫</div></div>',
     '<div class="card reveal reveal-delay-1" onclick="go(\'n2\')"><div class="ph" style="padding:0;overflow:hidden"><img src="public/images/kekeli-gallery-orchard-volta-school.jpg" alt="Orchard and Poultry at Volta School for the Deaf" style="width:100%;height:100%;object-fit:cover"></div>'),
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
