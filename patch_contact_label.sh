python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

replacements = [
    ('<li><button id="nb-contact" onclick="go(\'contact\')">Contact</button></li>',
     '<li><button id="nb-contact" onclick="go(\'contact\')">Contact Us</button></li>'),
    ('<button onclick="go(\'contact\');closeMob()">Contact</button>',
     '<button onclick="go(\'contact\');closeMob()">Contact Us</button>'),
    ('<div class="fcol"><h4>Contact</h4><ul>',
     '<div class="fcol"><h4>Contact Us</h4><ul>'),
]

applied = 0
skipped = 0
for old, new in replacements:
    if old in h:
        h = h.replace(old, new)
        applied += 1
    else:
        skipped += 1

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)

print(f"Applied: {applied}, Already done/skipped: {skipped}")
PYEOF
