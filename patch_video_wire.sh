python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

old = '''<div style="margin-top:32px">
      <h3 class="h3" style="margin-bottom:12px">📹 Field Videos</h3>
      <div class="video-embed">
        <div class="video-placeholder"><div class="phi">🎬</div><div class="pht">Video Placeholder — Borehole Commissioning Footage</div></div>
      </div>
    </div>'''

new = '''<div style="margin-top:32px">
      <h3 class="h3" style="margin-bottom:12px">📹 Field Videos</h3>
      <div class="video-embed">
        <video controls preload="metadata"><source src="public/videos/kekeli-anyiheme-borehole.mp4" type="video/mp4"></video>
      </div>
      <p style="font-size:12.5px;color:var(--slate);text-align:center;margin-top:10px;line-height:1.6">Akatsi-Anyiheme E.P. Basic School Mechanised Borehole, donated by Kekeli Co-operative For The Needy (LBG) on behalf of Seth and Avery, by Love Zaida and Bubba</p>
    </div>'''

if old in h:
    h = h.replace(old, new)
    print("index.html: video wired in with caption")
elif 'kekeli-anyiheme-borehole.mp4' in h:
    print("index.html: already wired — skipped")
else:
    print("index.html: WARNING — old block not found, check manually")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)
PYEOF
