python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

files = [
    "70th-borehole-filomena-bankovich.jpg",
    "akatsi-anyiheme-borehole.jpg",
    "apple-touch-icon.png",
    "borehole-70th-school.jpg",
    "dzogadze-borehole.jpg",
    "favicon.png",
    "gui-75th-borehole-names.jpg",
    "kekeli-og-image.png",
    "logo-mark.png",
    "peter-samlafo-60th-borehole.jpg",
    "school-assembly.jpg",
    "togbe-dorglo-anumah-vi.jpg",
    "toy-distribution.jpg",
]

applied = 0
skipped = 0
for fname in files:
    old = f"images/{fname}"
    new = f"public/images/{fname}"
    if new in h:
        skipped += 1
    elif old in h:
        count = h.count(old)
        h = h.replace(old, new)
        applied += count
    else:
        print(f"WARNING: {fname} not found in either old or new form")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)

print(f"Applied: {applied} path replacements, Already-done files skipped: {skipped}")
PYEOF
