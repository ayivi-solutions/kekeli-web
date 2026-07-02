python3 << 'PYEOF'
with open('index.html', encoding='utf-8') as f:
    h = f.read()

old1 = '<div class="gitem reveal" data-cat="water"><div class="ph"><div class="phi">💧</div><div class="pht">Photo Placeholder</div></div><div class="gitem-cap"><div class="gcat">Water</div><div class="gname">75th Borehole — Gui</div></div></div>'
new1 = '<div class="gitem reveal" data-cat="water"><div class="ph" style="padding:0;overflow:hidden"><img src="images/gui-75th-borehole-names.jpg" alt="75th Borehole, Gui" style="width:100%;height:100%;object-fit:cover"></div><div class="gitem-cap"><div class="gcat">Water</div><div class="gname">75th Borehole — Gui</div></div></div>'

old2 = '<div class="gitem reveal reveal-delay-3" data-cat="events"><div class="ph" style="padding:0;overflow:hidden"><img src="images/borehole-70th-school.jpg" alt="70th Borehole Celebration, Wovenu Senior High Technical School" style="width:100%;height:100%;object-fit:cover"></div><div class="gitem-cap"><div class="gcat">Events</div><div class="gname">70th Borehole — Wovenu SHTS</div></div></div>\n    </div>'
new2 = '''<div class="gitem reveal reveal-delay-3" data-cat="events"><div class="ph" style="padding:0;overflow:hidden"><img src="images/borehole-70th-school.jpg" alt="70th Borehole Celebration, Wovenu Senior High Technical School" style="width:100%;height:100%;object-fit:cover"></div><div class="gitem-cap"><div class="gcat">Events</div><div class="gname">70th Borehole — Wovenu SHTS</div></div></div>
      <div class="gitem reveal" data-cat="water"><div class="ph" style="padding:0;overflow:hidden"><img src="images/peter-samlafo-60th-borehole.jpg" alt="60th Borehole, in honour of Peter Samlafo" style="width:100%;height:100%;object-fit:cover"></div><div class="gitem-cap"><div class="gcat">Water</div><div class="gname">60th Borehole — In Honour of Peter Samlafo</div></div></div>
      <div class="gitem reveal reveal-delay-1" data-cat="water"><div class="ph" style="padding:0;overflow:hidden"><img src="images/akatsi-anyiheme-borehole.jpg" alt="Akatsi Anyiheme Basic School Borehole" style="width:100%;height:100%;object-fit:cover"></div><div class="gitem-cap"><div class="gcat">Water</div><div class="gname">Akatsi Anyiheme Basic School Borehole</div></div></div>
      <div class="gitem reveal reveal-delay-2" data-cat="water"><div class="ph" style="padding:0;overflow:hidden"><img src="images/70th-borehole-filomena-bankovich.jpg" alt="70th Borehole, in honour of the Filomena and Bankovich Families" style="width:100%;height:100%;object-fit:cover"></div><div class="gitem-cap"><div class="gcat">Water</div><div class="gname">70th Borehole — Filomena &amp; Bankovich Families</div></div></div>
      <div class="gitem reveal reveal-delay-3" data-cat="community"><div class="ph" style="padding:0;overflow:hidden"><img src="images/toy-distribution.jpg" alt="Toy distribution, community outreach" style="width:100%;height:100%;object-fit:cover"></div><div class="gitem-cap"><div class="gcat">Community &amp; Health</div><div class="gname">Toy Distribution, Community Outreach</div></div></div>
      <div class="gitem reveal" data-cat="community"><div class="ph" style="padding:0;overflow:hidden"><img src="images/school-assembly.jpg" alt="School assembly, community engagement" style="width:100%;height:100%;object-fit:cover"></div><div class="gitem-cap"><div class="gcat">Community &amp; Health</div><div class="gname">School Assembly, Community Engagement</div></div></div>
    </div>'''

applied = 0
skipped = 0
for old, new in [(old1, new1), (old2, new2)]:
    if old in h:
        h = h.replace(old, new)
        applied += 1
    elif new in h:
        skipped += 1
    else:
        print("WARNING: pattern not found, check manually:", old[:80])

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(h)

print(f"Applied: {applied}, Already done/skipped: {skipped}")
PYEOF
