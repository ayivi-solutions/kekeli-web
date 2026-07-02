python3 << 'PYEOF'
with open('css/style.css', encoding='utf-8') as f:
    c = f.read()

old_css = '''.scrolltop{
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

new_css = '''.scrolltop{
  position:fixed;bottom:92px;right:20px;width:46px;height:46px;border-radius:50%;
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
  position:fixed;top:50%;right:0;width:58px;height:58px;border-radius:50% 0 0 50%;
  background:linear-gradient(135deg,var(--gold),var(--amber));color:var(--deep);
  border:2px solid rgba(255,255,255,.4);border-right:none;
  font-size:24px;cursor:pointer;z-index:851;
  box-shadow:-4px 4px 24px rgba(200,149,42,.45);
  display:flex;align-items:center;justify-content:center;
  transform:translateY(-50%);
  transition:all .3s var(--ease-spring);
  animation:fab-pulse 2.6s ease-in-out infinite;
}
.fab-donate:hover{transform:translateY(-50%) translateX(-4px) scale(1.08);box-shadow:-6px 6px 28px rgba(200,149,42,.6)}
@keyframes fab-pulse{0%,100%{box-shadow:-4px 4px 24px rgba(200,149,42,.45)}50%{box-shadow:-4px 4px 24px rgba(200,149,42,.75),0 0 0 8px rgba(200,149,42,.12)}}
@media(max-width:640px){.fab-donate{width:50px;height:50px;font-size:20px}.scrolltop{bottom:86px;right:16px;width:42px;height:42px}}'''

if old_css in c:
    c = c.replace(old_css, new_css)
    with open('css/style.css', 'w', encoding='utf-8') as f:
        f.write(c)
    print("style.css: donate FAB repositioned to mid-right")
elif '50%;right:0' in c.replace(' ', ''):
    print("style.css: already repositioned — skipped")
else:
    print("style.css: WARNING — old CSS block not found, no changes made. Check manually.")
PYEOF
