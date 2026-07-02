python3 << 'PYEOF'
# ---- index.html ----
with open('index.html', encoding='utf-8') as f:
    h = f.read()

if 'tbar-brand' not in h:
    h = h.replace(
        '<div class="topbar">\n  <span>📍 Akatsi South, Volta Region, Ghana</span><span class="tsep">|</span>',
        '<div class="topbar">\n  <strong class="tbar-brand">KEKELI CO-OPERATIVE FOR THE NEEDY LBG</strong>\n  <span class="tbar-spacer"></span>\n  <span>📍 Akatsi South, Volta Region, Ghana</span><span class="tsep">|</span>'
    )
    with open('index.html', 'w', encoding='utf-8') as f:
        f.write(h)
    print("index.html: topbar brand added")
else:
    print("index.html: topbar brand already present — skipped")

if 'fab-donate' not in h:
    with open('index.html', encoding='utf-8') as f:
        h = f.read()
    h = h.replace(
        '<button class="scrolltop" id="scrollTop" onclick="window.scrollTo({top:0,behavior:\'smooth\'})" aria-label="Scroll to top">↑</button>',
        '<button class="scrolltop" id="scrollTop" onclick="window.scrollTo({top:0,behavior:\'smooth\'})" aria-label="Scroll to top">↑</button>\n<button class="fab-donate" onclick="go(\'donate\')" aria-label="Donate Now">❤️</button>'
    )
    with open('index.html', 'w', encoding='utf-8') as f:
        f.write(h)
    print("index.html: donate FAB added")
else:
    print("index.html: donate FAB already present — skipped")

# ---- css/style.css ----
with open('css/style.css', encoding='utf-8') as f:
    c = f.read()

old_topbar_css = '''.topbar{
  position:fixed;top:0;left:0;right:0;z-index:1001;
  height:var(--topbar-h);
  background:var(--deep);
  color:rgba(255,255,255,.55);
  font-size:11.5px;font-weight:500;
  padding:0 20px;
  display:flex;align-items:center;justify-content:center;
  gap:20px;flex-wrap:nowrap;letter-spacing:.02em;
  overflow-x:auto;-webkit-overflow-scrolling:touch;scrollbar-width:none;
  white-space:nowrap;
}
.topbar::-webkit-scrollbar{display:none}
.topbar a{color:var(--mint);transition:color .2s}.topbar a:hover{color:var(--white)}
.tsep{color:rgba(255,255,255,.2)}'''

new_topbar_css = '''.topbar{
  position:fixed;top:0;left:0;right:0;z-index:1001;
  height:var(--topbar-h);
  background:var(--deep);
  color:rgba(255,255,255,.55);
  font-size:11.5px;font-weight:500;
  padding:0 20px;
  display:flex;align-items:center;justify-content:flex-start;
  gap:14px;flex-wrap:nowrap;letter-spacing:.02em;
  overflow-x:auto;-webkit-overflow-scrolling:touch;scrollbar-width:none;
  white-space:nowrap;
}
.topbar::-webkit-scrollbar{display:none}
.topbar a{color:var(--mint);transition:color .2s}.topbar a:hover{color:var(--white)}
.tsep{color:rgba(255,255,255,.2)}
.tbar-brand{color:var(--white);font-weight:700;letter-spacing:.08em;font-size:11.5px;flex-shrink:0}
.tbar-spacer{flex:1 1 auto;min-width:12px}'''

if '.tbar-brand{' not in c:
    c = c.replace(old_topbar_css, new_topbar_css)
    print("style.css: topbar brand styles added")
else:
    print("style.css: topbar brand styles already present — skipped")

old_scrolltop_css = '''.scrolltop{
  position:fixed;bottom:92px;right:20px;width:46px;height:46px;border-radius:50%;
  background:var(--forest);color:var(--white);border:2px solid var(--jade);
  font-size:18px;cursor:pointer;z-index:850;
  box-shadow:0 6px 24px rgba(0,0,0,.25);
  display:flex;align-items:center;justify-content:center;
  opacity:0;transform:translateY(12px) scale(.85);pointer-events:none;
  transition:all .3s var(--ease-spring);
}
.scrolltop.show{opacity:1;transform:translateY(0) scale(1);pointer-events:all}
.scrolltop:hover{background:var(--sage);transform:translateY(-3px) scale(1.06)}'''

new_scrolltop_css = '''.scrolltop{
  position:fixed;bottom:162px;right:20px;width:46px;height:46px;border-radius:50%;
  background:var(--forest);color:var(--white);border:2px solid var(--jade);
  font-size:18px;cursor:pointer;z-index:850;
  box-shadow:0 6px 24px rgba(0,0,0,.25);
  display:flex;align-items:center;justify-content:center;
  opacity:0;transform:translateY(12px) scale(.85);pointer-events:none;
  transition:all .3s var(--ease-spring);
}
.scrolltop.show{opacity:1;transform:translateY(0) scale(1);pointer-events:all}
.scrolltop:hover{background:var(--sage);transform:translateY(-3px) scale(1.06)}
.fab-donate{
  position:fixed;bottom:92px;right:20px;width:58px;height:58px;border-radius:50%;
  background:linear-gradient(135deg,var(--gold),var(--amber));color:var(--deep);
  border:2px solid rgba(255,255,255,.4);
  font-size:24px;cursor:pointer;z-index:851;
  box-shadow:0 8px 28px rgba(200,149,42,.45);
  display:flex;align-items:center;justify-content:center;
  transition:all .3s var(--ease-spring);
  animation:fab-pulse 2.6s ease-in-out infinite;
}
.fab-donate:hover{transform:translateY(-3px) scale(1.08);box-shadow:0 10px 32px rgba(200,149,42,.6)}
@keyframes fab-pulse{0%,100%{box-shadow:0 8px 28px rgba(200,149,42,.45)}50%{box-shadow:0 8px 28px rgba(200,149,42,.75),0 0 0 8px rgba(200,149,42,.12)}}
@media(max-width:640px){.fab-donate{width:52px;height:52px;font-size:21px;bottom:86px;right:16px}.scrolltop{bottom:146px;right:18px;width:42px;height:42px}}'''

if '.fab-donate{' not in c:
    c = c.replace(old_scrolltop_css, new_scrolltop_css)
    print("style.css: donate FAB styles added")
else:
    print("style.css: donate FAB styles already present — skipped")

with open('css/style.css', 'w', encoding='utf-8') as f:
    f.write(c)
PYEOF
