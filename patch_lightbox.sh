python3 << 'PYEOF'
import re

with open('index.html', encoding='utf-8') as f:
    h = f.read()

if 'id="lightbox"' not in h:
    pattern = re.compile(r'<img src="(public/images/(?!logo-mark)[^"]+)" alt="([^"]*)" style="([^"]*)">')

    def repl(m):
        src, alt, style = m.group(1), m.group(2), m.group(3)
        return f'<img src="{src}" alt="{alt}" style="{style};cursor:pointer" onclick="event.stopPropagation();openLightbox(this.src,this.alt)">'

    h, count = pattern.subn(repl, h)
    print(f"index.html: {count} image tags made clickable")

    old_end = '''  <div class="cookie-actions">
    <button class="cookie-btn-essential" onclick="cookieChoice('essential')">Essential Only</button>
    <button class="cookie-btn-accept" onclick="cookieChoice('accept')">Accept All</button>
  </div>
</div>

<script src="js/main.js" defer></script>
</body>
</html>'''

    new_end = '''  <div class="cookie-actions">
    <button class="cookie-btn-essential" onclick="cookieChoice('essential')">Essential Only</button>
    <button class="cookie-btn-accept" onclick="cookieChoice('accept')">Accept All</button>
  </div>
</div>

<div class="lightbox" id="lightbox" onclick="closeLightbox()">
  <button class="lightbox-close" onclick="closeLightbox()" aria-label="Close">✕</button>
  <img class="lightbox-img" id="lightboxImg" src="" alt="" onclick="event.stopPropagation()">
  <div class="lightbox-caption" id="lightboxCaption"></div>
</div>

<script src="js/main.js" defer></script>
</body>
</html>'''

    if old_end in h:
        h = h.replace(old_end, new_end)
        print("index.html: lightbox modal markup added")
    else:
        print("index.html: WARNING — end-of-body anchor not found, check manually")

    with open('index.html', 'w', encoding='utf-8') as f:
        f.write(h)
else:
    print("index.html: lightbox already present — skipped")

with open('css/style.css', encoding='utf-8') as f:
    c = f.read()

if '.lightbox{' not in c:
    c += '''

/* ── LIGHTBOX ──────────────────────────────────────────────────── */
.lightbox{
  position:fixed;inset:0;z-index:2000;
  background:rgba(4,15,9,.94);
  display:flex;align-items:center;justify-content:center;
  padding:40px 20px;
  opacity:0;visibility:hidden;
  transition:opacity .3s ease,visibility .3s ease;
}
.lightbox.show{opacity:1;visibility:visible}
.lightbox-img{
  max-width:100%;max-height:80vh;
  border-radius:8px;
  box-shadow:0 20px 60px rgba(0,0,0,.5);
  cursor:default;
  transform:scale(.95);
  transition:transform .3s ease;
}
.lightbox.show .lightbox-img{transform:scale(1)}
.lightbox-close{
  position:absolute;top:20px;right:20px;
  width:44px;height:44px;border-radius:50%;
  background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.25);
  color:#fff;font-size:18px;cursor:pointer;
  display:flex;align-items:center;justify-content:center;
  transition:background .2s;
}
.lightbox-close:hover{background:rgba(255,255,255,.2)}
.lightbox-caption{
  position:absolute;bottom:24px;left:0;right:0;
  text-align:center;color:rgba(255,255,255,.85);
  font-family:'Syne',sans-serif;font-size:13px;font-weight:600;
  padding:0 20px;
}
@media(max-width:600px){
  .lightbox-close{top:12px;right:12px;width:38px;height:38px;font-size:15px}
}
'''
    with open('css/style.css', 'w', encoding='utf-8') as f:
        f.write(c)
    print("style.css: lightbox CSS added")
else:
    print("style.css: lightbox CSS already present — skipped")

with open('js/main.js', encoding='utf-8') as f:
    j = f.read()

old_init = '''/* ── INIT ──────────────────────────────────────────────────────── */
document.addEventListener('DOMContentLoaded',()=>{
  observeReveals();
  observeCounters();
  observeBars();
  initScrollspy();
  updateScrollProgress();
  initCookieBanner();
  initHeroSlideshow();'''

new_init = '''/* ── LIGHTBOX ──────────────────────────────────────────────────── */
function openLightbox(src, alt){
  const lb = document.getElementById('lightbox');
  const img = document.getElementById('lightboxImg');
  const cap = document.getElementById('lightboxCaption');
  img.src = src;
  img.alt = alt || '';
  cap.textContent = alt || '';
  lb.classList.add('show');
  document.body.style.overflow = 'hidden';
}
function closeLightbox(){
  const lb = document.getElementById('lightbox');
  lb.classList.remove('show');
  document.body.style.overflow = '';
}
document.addEventListener('keydown', (e) => {
  if(e.key === 'Escape') closeLightbox();
});

/* ── INIT ──────────────────────────────────────────────────────── */
document.addEventListener('DOMContentLoaded',()=>{
  observeReveals();
  observeCounters();
  observeBars();
  initScrollspy();
  updateScrollProgress();
  initCookieBanner();
  initHeroSlideshow();'''

if 'function openLightbox' not in j:
    if old_init in j:
        j = j.replace(old_init, new_init)
        print("main.js: lightbox functions added")
    else:
        print("main.js: WARNING — init anchor not found, check manually")
    with open('js/main.js', 'w', encoding='utf-8') as f:
        f.write(j)
else:
    print("main.js: lightbox functions already present — skipped")
PYEOF
