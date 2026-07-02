python3 << 'PYEOF'
import re

# ---- index.html ----
with open('index.html', encoding='utf-8') as f:
    h = f.read()

if 'id="nb-gallery"' not in h:
    h = h.replace(
        '<li><button id="nb-work" onclick="go(\'work\')">Our Work</button></li>\n      <li><button id="nb-impact" onclick="go(\'impact\')">Impact &amp; Reports</button></li>',
        '<li><button id="nb-work" onclick="go(\'work\')">Our Work</button></li>\n      <li><button id="nb-gallery" onclick="go(\'gallery\')">Gallery</button></li>\n      <li><button id="nb-impact" onclick="go(\'impact\')">Impact &amp; Reports</button></li>'
    )
    h = h.replace(
        "<button onclick=\"go('work');closeMob()\">Our Work</button>\n  <button onclick=\"go('impact');closeMob()\">Impact &amp; Reports</button>",
        "<button onclick=\"go('work');closeMob()\">Our Work</button>\n  <button onclick=\"go('gallery');closeMob()\">Gallery</button>\n  <button onclick=\"go('impact');closeMob()\">Impact &amp; Reports</button>"
    )
    h = h.replace(
        '<li><button onclick="go(\'work-edu\')">Community &amp; Health</button></li>\n      <li><button onclick="go(\'impact\')">Impact &amp; Reports</button></li>',
        '<li><button onclick="go(\'work-edu\')">Community &amp; Health</button></li>\n      <li><button onclick="go(\'gallery\')">Gallery</button></li>\n      <li><button onclick="go(\'impact\')">Impact &amp; Reports</button></li>'
    )
    gallery_section = '''<!-- ══ GALLERY / MEDIA ═════════════════════════════════ -->

<div id="gallery" class="mainsec">
  <div class="dh"><div class="dh-inner"><div class="lbl">Media</div><h1>Gallery</h1><p>Photos from the field — borehole commissionings, reforestation sites, community programmes and events across the Avenor Traditional Area.</p></div></div>
  <section class="sec"><div class="wrap">
    <div class="gfilter-row">
      <button class="gfilter-btn on" onclick="filterGallery('all',this)">All</button>
      <button class="gfilter-btn" onclick="filterGallery('water',this)">💧 Water</button>
      <button class="gfilter-btn" onclick="filterGallery('reforestation',this)">🌴 Reforestation</button>
      <button class="gfilter-btn" onclick="filterGallery('community',this)">🤝 Community &amp; Health</button>
      <button class="gfilter-btn" onclick="filterGallery('events',this)">📅 Events</button>
    </div>
    <div class="g4" id="galleryGrid">
      <div class="gitem reveal" data-cat="water"><div class="ph"><div class="phi">💧</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Water</div><div class="gname">75th Borehole — Gui</div></div></div>
      <div class="gitem reveal reveal-delay-1" data-cat="water"><div class="ph"><div class="phi">💧</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Water</div><div class="gname">Borehole Commissioning</div></div></div>
      <div class="gitem reveal reveal-delay-2" data-cat="reforestation"><div class="ph"><div class="phi">🌴</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Reforestation</div><div class="gname">Palm Planting, Dzogadze</div></div></div>
      <div class="gitem reveal reveal-delay-3" data-cat="reforestation"><div class="ph"><div class="phi">🥥</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Reforestation</div><div class="gname">Coconut Site, Akeve</div></div></div>
      <div class="gitem reveal" data-cat="community"><div class="ph"><div class="phi">🍊</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Community &amp; Health</div><div class="gname">Orchard, Volta School for the Deaf</div></div></div>
      <div class="gitem reveal reveal-delay-1" data-cat="community"><div class="ph"><div class="phi">🐔</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Community &amp; Health</div><div class="gname">Poultry Farm</div></div></div>
      <div class="gitem reveal reveal-delay-2" data-cat="community"><div class="ph"><div class="phi">🏥</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Community &amp; Health</div><div class="gname">Dzogadze Medical Clinic</div></div></div>
      <div class="gitem reveal reveal-delay-3" data-cat="events"><div class="ph"><div class="phi">🎙️</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Events</div><div class="gname">Commissioning Ceremony, Gui</div></div></div>
    </div>
    <div class="hbox reveal" style="margin-top:24px"><h4>📷 More Photos Coming Soon</h4><p>This gallery is being populated with real photography from Kekeli's field operations. Check back regularly, or follow our social channels for the latest updates.</p></div>
  </div></section>
</div>

<div id="impact" class="mainsec">'''
    h = h.replace('<div id="impact" class="mainsec">', gallery_section, 1)
    with open('index.html', 'w', encoding='utf-8') as f:
        f.write(h)
    print("index.html patched")
else:
    print("index.html already has Gallery — skipped")

# ---- css/style.css ----
with open('css/style.css', encoding='utf-8') as f:
    c = f.read()

if '.gfilter-row' not in c:
    gallery_css = '''.phlg{height:240px}.pher{height:300px;border-radius:16px;border:1px solid rgba(46,139,87,.15)}
.gfilter-row{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:28px}
.gfilter-btn{background:var(--white);border:1.5px solid var(--bdr);color:var(--slate);padding:9px 18px;border-radius:100px;font-size:13px;font-weight:600;cursor:pointer;transition:all .2s;font-family:inherit}
.gfilter-btn.on{border-color:var(--jade);background:var(--foam);color:var(--forest)}
.gitem{border-radius:16px;overflow:hidden;border:1px solid rgba(46,139,87,.15);background:var(--white);transition:transform .25s var(--ease-out),box-shadow .25s}
.gitem:hover{transform:translateY(-4px);box-shadow:0 10px 28px rgba(15,61,38,.12)}
.gitem .ph{height:180px;border-radius:0}
.gitem-cap{padding:12px 14px}
.gitem-cap .gcat{font-size:10.5px;font-weight:700;color:var(--jade);text-transform:uppercase;letter-spacing:.08em}
.gitem-cap .gname{font-size:13.5px;color:var(--forest);font-weight:700;margin-top:3px}
.gitem.hidden{display:none}'''
    c = c.replace('.phlg{height:240px}.pher{height:300px;border-radius:16px;border:1px solid rgba(46,139,87,.15)}', gallery_css, 1)
    with open('css/style.css', 'w', encoding='utf-8') as f:
        f.write(c)
    print("style.css patched")
else:
    print("style.css already has Gallery — skipped")

# ---- js/main.js ----
with open('js/main.js', encoding='utf-8') as f:
    j = f.read()

if 'function filterGallery' not in j:
    j = j.replace(
        "'edu-orchard':'nb-work','edu-poultry':'nb-work',\n  impact:'nb-impact'",
        "'edu-orchard':'nb-work','edu-poultry':'nb-work',\n  gallery:'nb-gallery',\n  impact:'nb-impact'"
    )
    j = j.replace(
        "const SCROLL_IDS=new Set(['home','about','work','work-water','work-agri','work-edu','impact','partners','news','contact','donate']);",
        "const SCROLL_IDS=new Set(['home','about','work','work-water','work-agri','work-edu','gallery','impact','partners','news','contact','donate']);\n\n/* ── GALLERY FILTER ────────────────────────────────────────────── */\nfunction filterGallery(cat, btn){\n  document.querySelectorAll('.gfilter-btn').forEach(b=>b.classList.remove('on'));\n  btn.classList.add('on');\n  document.querySelectorAll('#galleryGrid .gitem').forEach(item=>{\n    const match = cat==='all' || item.dataset.cat===cat;\n    item.classList.toggle('hidden', !match);\n  });\n}"
    )
    with open('js/main.js', 'w', encoding='utf-8') as f:
        f.write(j)
    print("main.js patched")
else:
    print("main.js already has Gallery — skipped")
PYEOF
