python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

applied = 0
skipped = 0

def do(old, new, marker=None):
    global h, applied, skipped
    if marker and marker in h:
        skipped += 1
        return
    if old in h:
        h = h.replace(old, new)
        applied += 1
    else:
        skipped += 1

do(
'''    <div class="g3" style="margin-bottom:40px">
      <div class="reveal" style="background:linear-gradient(135deg,var(--foam),var(--mist));border-radius:20px;padding:28px 20px;text-align:center;border:1px solid rgba(46,139,87,.15)"><div class="impnum"><span class="cnum" data-target="75">0</span></div><div class="lbl" style="margin-top:8px">Boreholes Commissioned</div></div>
      <div class="reveal reveal-delay-1" style="background:linear-gradient(135deg,var(--foam),var(--mist));border-radius:20px;padding:28px 20px;text-align:center;border:1px solid rgba(46,139,87,.15)"><div class="impnum" style="font-size:clamp(28px,4vw,50px)">GHS <span class="cnum" data-target="60">0</span>K</div><div class="lbl" style="margin-top:8px">Value Per Borehole</div></div>
      <div class="reveal reveal-delay-2" style="background:linear-gradient(135deg,var(--cream),#fef5e0);border-radius:20px;padding:28px 20px;text-align:center;border:1px solid rgba(200,149,42,.2)"><div class="impnum">GHS <span class="cnum" data-target="4">0</span>.5M</div><div class="lbl" style="margin-top:8px;color:var(--gold)">Total Asset Base</div></div>
    </div>
    <div class="map-wrap reveal">
      <div class="map-icon">🗺️</div>
      <h3 class="h3" style="margin-bottom:6px">Serving the Avenor Traditional Area</h3>
      <p style="color:var(--slate);font-size:13px;margin-bottom:4px">Kekeli is situated in Akatsi, the administrative capital of Akatsi South Municipal — the 75 boreholes and other projects extend across the wider Avenor Traditional Area, in the Volta Region.</p>
      <p style="color:var(--slate);font-size:11px">Over 300 villages, 10 schools and an estimated 200,000 people served. GPS coordinates for all sites are held on record.</p>
      <div class="rgrid">
        <div class="rcard"><div class="rnum">75</div><div class="rlbl">Boreholes</div><div class="rname">Avenor Traditional Area</div></div>
        <div class="rcard"><div class="rnum">300+</div><div class="rlbl">Communities</div><div class="rname">Avenor Traditional Area</div></div>
        <div class="rcard"><div class="rnum">10</div><div class="rlbl">Schools Served</div><div class="rname">Including Volta School for the Deaf</div></div>
      </div>
      <div style="margin-top:24px">''',
'''    <div class="g3" style="margin-bottom:40px">
      <div class="reveal" style="background:linear-gradient(135deg,var(--foam),var(--mist));border-radius:20px;padding:28px 20px;text-align:center;border:1px solid rgba(46,139,87,.15)"><div class="impnum"><span class="cnum" data-target="75">0</span></div><div class="lbl" style="margin-top:8px">Boreholes Commissioned</div></div>
      <div class="reveal reveal-delay-1" style="background:linear-gradient(135deg,var(--foam),var(--mist));border-radius:20px;padding:28px 20px;text-align:center;border:1px solid rgba(46,139,87,.15)"><div class="impnum" style="font-size:clamp(28px,4vw,50px)">GHS <span class="cnum" data-target="60">0</span>K</div><div class="lbl" style="margin-top:8px">Value Per Borehole</div></div>
      <div class="reveal reveal-delay-2" style="background:linear-gradient(135deg,var(--cream),#fef5e0);border-radius:20px;padding:28px 20px;text-align:center;border:1px solid rgba(200,149,42,.2)"><div class="impnum">GHS <span class="cnum" data-target="4">0</span>.5M</div><div class="lbl" style="margin-top:8px;color:var(--gold)">Total Asset Base</div></div>
      <div class="reveal reveal-delay-3" style="background:linear-gradient(135deg,var(--foam),var(--mist));border-radius:20px;padding:28px 20px;text-align:center;border:1px solid rgba(46,139,87,.15)"><div class="impnum"><span class="cnum" data-target="300">0</span>+</div><div class="lbl" style="margin-top:8px">Communities Served</div></div>
      <div class="reveal reveal-delay-4" style="background:linear-gradient(135deg,var(--foam),var(--mist));border-radius:20px;padding:28px 20px;text-align:center;border:1px solid rgba(46,139,87,.15)"><div class="impnum"><span class="cnum" data-target="10">0</span></div><div class="lbl" style="margin-top:8px">Schools Served</div></div>
    </div>
    <div class="map-wrap reveal">
      <div class="map-icon">🗺️</div>
      <h3 class="h3" style="margin-bottom:6px">Serving the Avenor Traditional Area</h3>
      <p style="color:var(--slate);font-size:13px;margin-bottom:4px">Kekeli is situated in Akatsi, the administrative capital of Akatsi South Municipal — the 75 boreholes and other projects extend across the wider Avenor Traditional Area, in the Volta Region.</p>
      <p style="color:var(--slate);font-size:11px">An estimated 200,000 people benefit from clean water access across these communities. GPS coordinates for all sites are held on record.</p>
      <div style="margin-top:24px">''',
marker='Communities Served')

do(
'<div class="ti"><span class="ti-dot"></span>250+ Communities Served</div>',
'<div class="ti"><span class="ti-dot"></span>300+ Communities Served</div>')

do(
'''  <section class="hero">
    <div class="hero-orb orb1"></div>
    <div class="hero-orb orb2"></div>
    <div class="hero-orb orb3"></div>
    <div class="hero-grid"></div>''',
'''  <section class="hero">
    <div class="hero-slideshow">
      <div class="hero-slide active" style="background-image:url('images/gui-75th-borehole-names.jpg')"></div>
      <div class="hero-slide" style="background-image:url('images/dzogadze-borehole.jpg')"></div>
      <div class="hero-slide" style="background-image:url('images/toy-distribution.jpg')"></div>
      <div class="hero-slide" style="background-image:url('images/school-assembly.jpg')"></div>
      <div class="hero-slide" style="background-image:url('images/borehole-70th-school.jpg')"></div>
      <div class="hero-slide" style="background-image:url('images/akatsi-anyiheme-borehole.jpg')"></div>
    </div>
    <div class="hero-scrim"></div>
    <div class="hero-orb orb1"></div>
    <div class="hero-orb orb2"></div>
    <div class="hero-orb orb3"></div>
    <div class="hero-grid"></div>''',
marker='hero-slideshow')

do(
'''        <div class="scell" onclick="go('impact')"><div class="snum"><span class="cnum" data-target="300">0</span><em>+</em></div><div class="slbl">Villages Served</div></div>
      </div>
    </div>
  </section>''',
'''        <div class="scell" onclick="go('impact')"><div class="snum"><span class="cnum" data-target="300">0</span><em>+</em></div><div class="slbl">Villages Served</div></div>
      </div>
    </div>
    <div class="hero-caption" id="heroCaption">75th Borehole — Gui, June 2026</div>
  </section>''',
marker='id="heroCaption"')

do(
'<div class="hbox reveal" style="margin-top:24px"><h4>📷 More Photos Coming Soon</h4><p>This gallery is being populated with real photography from Kekeli\'s field operations. Check back regularly, or follow our social channels for the latest updates.</p></div>',
'''<div style="margin-top:32px">
      <h3 class="h3" style="margin-bottom:12px">📹 Field Videos</h3>
      <div class="video-embed">
        <div class="video-placeholder"><div class="phi">🎬</div><div class="pht">Video Placeholder — Borehole Commissioning Footage</div></div>
      </div>
    </div>
    <div class="hbox reveal" style="margin-top:24px"><h4>📷 More Photos Coming Soon</h4><p>This gallery is being populated with real photography from Kekeli\'s field operations. Check back regularly, or follow our social channels for the latest updates.</p></div>''',
marker='class="video-embed"')

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)

with open('css/style.css', encoding='utf-8') as f:
    c = f.read()

def doc(old, new, marker=None):
    global c, applied, skipped
    if marker and marker in c:
        skipped += 1
        return
    if old in c:
        c = c.replace(old, new)
        applied += 1
    else:
        skipped += 1

doc(
'''.hero{
  min-height:100svh;
  background:var(--deep);
  display:flex;flex-direction:column;justify-content:center;
  position:relative;overflow:hidden;
  padding:100px 20px 80px;
}''',
'''.hero{
  min-height:100svh;
  background:var(--deep);
  display:flex;flex-direction:column;justify-content:center;
  position:relative;overflow:hidden;
  padding:100px 20px 80px;
}
.hero-slideshow{position:absolute;inset:0;z-index:0}
.hero-slide{position:absolute;inset:0;background-size:cover;background-position:center;opacity:0;transition:opacity 1.8s ease-in-out}
.hero-slide.active{opacity:1}
.hero-scrim{position:absolute;inset:0;z-index:1;background:linear-gradient(150deg,rgba(4,15,9,.90) 0%,rgba(15,61,38,.84) 55%,rgba(26,94,53,.78) 100%)}
.hero-caption{position:absolute;bottom:24px;left:24px;z-index:3;color:rgba(255,255,255,.8);font-size:11.5px;font-family:'Syne',sans-serif;font-weight:700;letter-spacing:.04em;background:rgba(0,0,0,.35);padding:7px 16px;border-radius:100px;backdrop-filter:blur(8px);border:1px solid rgba(255,255,255,.12);transition:opacity .4s ease}''',
marker='.hero-slideshow{')

doc(
'.hero-orb{position:absolute;border-radius:50%;filter:blur(80px);animation:orb-drift 12s ease-in-out infinite alternate;pointer-events:none}',
'.hero-orb{position:absolute;z-index:1;border-radius:50%;filter:blur(80px);animation:orb-drift 12s ease-in-out infinite alternate;pointer-events:none}')

doc(
'''.hero-grid{
  position:absolute;inset:0;
  background-image:linear-gradient(rgba(168,230,194,.04) 1px,transparent 1px),linear-gradient(90deg,rgba(168,230,194,.04) 1px,transparent 1px);
  background-size:60px 60px;
  pointer-events:none;
}''',
'''.hero-grid{
  position:absolute;inset:0;z-index:1;
  background-image:linear-gradient(rgba(168,230,194,.04) 1px,transparent 1px),linear-gradient(90deg,rgba(168,230,194,.04) 1px,transparent 1px);
  background-size:60px 60px;
  pointer-events:none;
}''')

doc(
'.phlg{height:240px}.pher{height:300px;border-radius:16px;border:1px solid rgba(46,139,87,.15)}',
'''.phlg{height:240px}.pher{height:300px;border-radius:16px;border:1px solid rgba(46,139,87,.15)}
.video-embed{position:relative;width:100%;padding-top:56.25%;border-radius:16px;overflow:hidden;background:linear-gradient(135deg,var(--foam),#c0e8d0);margin-bottom:20px}
.video-embed iframe,.video-embed video{position:absolute;inset:0;width:100%;height:100%;border:0}
.video-placeholder{position:absolute;inset:0;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:8px}''',
marker='.video-embed{')

with open('css/style.css', 'w', encoding='utf-8') as f:
    f.write(c)

with open('js/main.js', encoding='utf-8') as f:
    j = f.read()

def doj(old, new, marker=None):
    global j, applied, skipped
    if marker and marker in j:
        skipped += 1
        return
    if old in j:
        j = j.replace(old, new)
        applied += 1
    else:
        skipped += 1

doj(
'''/* ── INIT ──────────────────────────────────────────────────────── */
document.addEventListener('DOMContentLoaded',()=>{
  observeReveals();
  observeCounters();
  observeBars();
  initScrollspy();
  updateScrollProgress();
  initCookieBanner();''',
'''/* ── HERO SLIDESHOW ────────────────────────────────────────────── */
const heroCaptions = [
  '75th Borehole — Gui, June 2026',
  'Dzogadze Mechanised Borehole',
  'Community Outreach &amp; Toy Distribution',
  'School Assembly, Community Engagement',
  '70th Borehole — Wovenu Senior High Technical School',
  'Akatsi Anyiheme Basic School Borehole'
];
let heroIdx = 0;
function rotateHero(){
  const slides = document.querySelectorAll('.hero-slide');
  if(!slides.length) return;
  slides[heroIdx].classList.remove('active');
  heroIdx = (heroIdx + 1) % slides.length;
  slides[heroIdx].classList.add('active');
  const capEl = document.getElementById('heroCaption');
  if(capEl){
    capEl.style.opacity = '0';
    setTimeout(()=>{
      capEl.innerHTML = heroCaptions[heroIdx] || '';
      capEl.style.opacity = '1';
    }, 400);
  }
}
function initHeroSlideshow(){
  if(document.querySelectorAll('.hero-slide').length){
    setInterval(rotateHero, 5000);
  }
}

/* ── INIT ──────────────────────────────────────────────────────── */
document.addEventListener('DOMContentLoaded',()=>{
  observeReveals();
  observeCounters();
  observeBars();
  initScrollspy();
  updateScrollProgress();
  initCookieBanner();
  initHeroSlideshow();''',
marker='function initHeroSlideshow')

with open('js/main.js', 'w', encoding='utf-8') as f:
    f.write(j)

print(f"Applied: {applied}, Already done/skipped: {skipped}")
PYEOF
