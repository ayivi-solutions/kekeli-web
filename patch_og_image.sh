python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

old = '''<meta property="og:url" content="https://kekeli4needy.com">
<!-- MEDIA: og:image must be a hosted URL (data URIs are not readable by social crawlers).
     Upload kekeli-og-image.png (provided) to this path before going live. -->
<meta property="og:image" content="https://kekeli4needy.com/assets/kekeli-og-image.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="Kekeli Co-operative For The Needy LBG — Water, Growth, Dignity, Hope">'''

new = '''<meta property="og:url" content="https://kekeli-web.pages.dev">
<!-- NOTE: og:url and og:image point to the current live Cloudflare Pages URL.
     Update both to the final custom domain once the Board confirms it. -->
<meta property="og:image" content="https://kekeli-web.pages.dev/images/kekeli-og-image.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="Kekeli Co-operative For The Needy LBG — Water, Growth, Dignity, Hope">'''

if old in h:
    h = h.replace(old, new)
    print("index.html: og:url and og:image updated")
elif 'kekeli-web.pages.dev/images/kekeli-og-image.png' in h:
    print("index.html: already updated — skipped")
else:
    print("index.html: WARNING — old meta block not found, check manually")

old_twitter = '<meta name="twitter:image" content="https://kekeli4needy.com/assets/kekeli-og-image.png">'
new_twitter = '<meta name="twitter:image" content="https://kekeli-web.pages.dev/images/kekeli-og-image.png">'

if old_twitter in h:
    h = h.replace(old_twitter, new_twitter)
    print("index.html: twitter:image updated")
elif 'twitter:image" content="https://kekeli-web.pages.dev' in h:
    print("index.html: twitter:image already updated — skipped")
else:
    print("index.html: WARNING — old twitter:image not found, check manually")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)
PYEOF
