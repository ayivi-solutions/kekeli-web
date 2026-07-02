python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    lines = f.readlines()

already_done = any('<div id="gallery" class="mainsec">' in l for l in lines) and \
    lines.index([l for l in lines if 'id="news" class="mainsec"' in l][0]) < \
    lines.index([l for l in lines if 'id="gallery" class="mainsec"' in l][0])

if already_done:
    print("index.html: Gallery already repositioned — skipped")
else:
    gallery_start = None
    gallery_end = None
    for i, line in enumerate(lines):
        if '<!-- ══ GALLERY / MEDIA' in line:
            gallery_start = i
        if gallery_start is not None and gallery_end is None and line.strip() == '<div id="impact" class="mainsec">':
            gallery_end = i
            break

    gallery_block = lines[gallery_start:gallery_end]
    remaining = lines[:gallery_start] + lines[gallery_end:]

    new_contact_start = None
    for i, line in enumerate(remaining):
        if line.strip() == '<div id="contact" class="mainsec">':
            new_contact_start = i
            break

    final = remaining[:new_contact_start] + gallery_block + ['\n'] + remaining[new_contact_start:]

    with open('index.html', 'w', encoding='utf-8') as f:
        f.writelines(final)
    print("index.html: Gallery section relocated to before Contact")

with open('index.html', encoding='utf-8') as f:
    h = f.read()

old_desktop_nav = '''<li><button id="nb-home" class="on" onclick="go('home')">Home</button></li>
      <li><button id="nb-about" onclick="go('about')">About Us</button></li>
      <li><button id="nb-work" onclick="go('work')">Our Work</button></li>
      <li><button id="nb-gallery" onclick="go('gallery')">Gallery</button></li>
      <li><button id="nb-impact" onclick="go('impact')">Impact &amp; Reports</button></li>
      <li><button id="nb-partners" onclick="go('partners')">Partners</button></li>
      <li><button id="nb-news" onclick="go('news')">News &amp; Updates</button></li>
      <li><button id="nb-contact" onclick="go('contact')">Contact Us</button></li>'''

new_desktop_nav = '''<li><button id="nb-home" class="on" onclick="go('home')">Home</button></li>
      <li><button id="nb-about" onclick="go('about')">About Us</button></li>
      <li><button id="nb-work" onclick="go('work')">Our Work</button></li>
      <li><button id="nb-impact" onclick="go('impact')">Impact &amp; Reports</button></li>
      <li><button id="nb-partners" onclick="go('partners')">Partners</button></li>
      <li><button id="nb-news" onclick="go('news')">News &amp; Updates</button></li>
      <li><button id="nb-gallery" onclick="go('gallery')">Gallery</button></li>
      <li><button id="nb-contact" onclick="go('contact')">Contact Us</button></li>'''

if old_desktop_nav in h:
    h = h.replace(old_desktop_nav, new_desktop_nav)
    print("index.html: desktop nav reordered")
else:
    print("index.html: desktop nav already reordered — skipped")

old_mobile_nav = '''<button onclick="go('home');closeMob()">Home</button>
  <button onclick="go('about');closeMob()">About Us</button>
  <button onclick="go('work');closeMob()">Our Work</button>
  <button onclick="go('gallery');closeMob()">Gallery</button>
  <button onclick="go('impact');closeMob()">Impact &amp; Reports</button>
  <button onclick="go('partners');closeMob()">Partners &amp; Donors</button>
  <button onclick="go('news');closeMob()">News &amp; Updates</button>
  <button onclick="go('contact');closeMob()">Contact Us</button>'''

new_mobile_nav = '''<button onclick="go('home');closeMob()">Home</button>
  <button onclick="go('about');closeMob()">About Us</button>
  <button onclick="go('work');closeMob()">Our Work</button>
  <button onclick="go('impact');closeMob()">Impact &amp; Reports</button>
  <button onclick="go('partners');closeMob()">Partners &amp; Donors</button>
  <button onclick="go('news');closeMob()">News &amp; Updates</button>
  <button onclick="go('gallery');closeMob()">Gallery</button>
  <button onclick="go('contact');closeMob()">Contact Us</button>'''

if old_mobile_nav in h:
    h = h.replace(old_mobile_nav, new_mobile_nav)
    print("index.html: mobile nav reordered")
else:
    print("index.html: mobile nav already reordered — skipped")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)
PYEOF
