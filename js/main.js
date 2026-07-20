/* ── NAV MAP ───────────────────────────────────────────────────── */
const NMAP={
  home:'nb-home',about:'nb-about',work:'nb-work',
  'work-water':'nb-work','work-agri':'nb-work','work-edu':'nb-work',
  'edu-orchard':'nb-work','edu-poultry':'nb-work',
  gallery:'nb-gallery',
  impact:'nb-impact',partners:'nb-partners',
  news:'nb-news',n1:'nb-news',n2:'nb-news',n3:'nb-news',
  contact:'nb-contact',donate:null
};

/* ── CONTINUOUS SCROLL vs CLICK-THROUGH PAGES ─────────────────── */
const SCROLL_IDS=new Set(['home','about','work','work-water','work-agri','work-edu','gallery','impact','partners','news','contact','donate']);

/* ── GALLERY FILTER ────────────────────────────────────────────── */
function filterGallery(cat, btn){
  document.querySelectorAll('.gfilter-btn').forEach(b=>b.classList.remove('on'));
  btn.classList.add('on');
  document.querySelectorAll('#galleryGrid .gitem').forEach(item=>{
    const match = cat==='all' || item.dataset.cat===cat;
    item.classList.toggle('hidden', !match);
  });
}

function setActiveNav(id){
  document.querySelectorAll('.nlinks button, .mnav button').forEach(b=>b.classList.remove('on'));
  const nb=NMAP[id];
  if(nb){
    document.querySelectorAll('#'+nb).forEach(el=>el.classList.add('on'));
  }
  if(id==='donate'){
    document.querySelectorAll('.ndonate,.mdonate').forEach(el=>el.classList.add('on'));
  }
}

/* ── PAGE NAV ──────────────────────────────────────────────────── */
function go(id){
  if(SCROLL_IDS.has(id)){
    // make sure the continuous scroll is showing (close any open click-through page)
    document.querySelectorAll('.pg').forEach(p=>p.classList.remove('on'));
    document.getElementById('main-scroll').classList.add('on');
    const target=document.getElementById(id);
    if(target)target.scrollIntoView({behavior:'smooth',block:'start'});
    setActiveNav(id);
  } else {
    // click-through secondary page: hide continuous scroll, show this page
    document.querySelectorAll('.pg').forEach(p=>p.classList.remove('on'));
    document.getElementById('main-scroll').classList.remove('on');
    const pg=document.getElementById('pg-'+id);
    if(pg){pg.classList.add('on');window.scrollTo({top:0,behavior:'smooth'})}
    setActiveNav(id);
  }
  setTimeout(observeReveals,50);
  setTimeout(observeCounters,50);
  setTimeout(observeBars,50);
}

function animateBars(ids,vals){
  ids.forEach((id,i)=>{
    const el=document.getElementById(id);
    if(el){el.style.width='0';requestAnimationFrame(()=>requestAnimationFrame(()=>{el.style.width=vals[i]+'%'}))}
  });
}

/* ── PROGRAMME-SPLIT BARS: TRIGGER ON SCROLL INTO VIEW ───────────── */
let barsObserver;
const BAR_GROUPS=[
  {container:'impact',ids:['af1','af2','af3','af4','af5'],vals:[52,18,14,10,6]},
  {container:'donate',ids:['daf1','daf2','daf3','daf4','daf5'],vals:[52,18,14,10,6]},
];
function observeBars(){
  if(!barsObserver){
    barsObserver=new IntersectionObserver((entries)=>{
      entries.forEach(e=>{
        if(e.isIntersecting){
          const grp=BAR_GROUPS.find(g=>g.container===e.target.id);
          if(grp)animateBars(grp.ids,grp.vals);
          barsObserver.unobserve(e.target);
        }
      });
    },{threshold:.3});
  }
  BAR_GROUPS.forEach(g=>{
    const el=document.getElementById(g.container);
    if(el && !el.dataset.barsObserved){
      el.dataset.barsObserved='1';
      barsObserver.observe(el);
    }
  });
}

/* ── SCROLLSPY: HIGHLIGHT NAV AS USER SCROLLS ────────────────────── */
let spyObserver;
function initScrollspy(){
  spyObserver=new IntersectionObserver((entries)=>{
    entries.forEach(e=>{
      if(e.isIntersecting){
        setActiveNav(e.target.id);
      }
    });
  },{rootMargin:'-45% 0px -50% 0px',threshold:0});
  document.querySelectorAll('.mainsec').forEach(el=>spyObserver.observe(el));
}

/* ── SCROLL PROGRESS BAR ──────────────────────────────────────────── */
function updateScrollProgress(){
  const doc=document.documentElement;
  const scrolled=doc.scrollTop;
  const height=doc.scrollHeight-doc.clientHeight;
  const pct=height>0?(scrolled/height)*100:0;
  const bar=document.getElementById('scrollProgress');
  if(bar)bar.style.width=pct+'%';
}

/* ── MOBILE MENU ───────────────────────────────────────────────── */
function toggleMob(){
  document.getElementById('mnav').classList.toggle('open');
  document.getElementById('hbtn').classList.toggle('open');
}
function closeMob(){
  document.getElementById('mnav').classList.remove('open');
  document.getElementById('hbtn').classList.remove('open');
}

/* ── DONATE — AMOUNT SELECTION ────────────────────────────────── */
let selAmount=100; let donateFreq='once';

function selAmt(el,v){
  document.querySelectorAll('.amtb').forEach(b=>b.classList.remove('sel'));
  if(el) el.classList.add('sel');
  const custom=document.getElementById('d-custom');
  if(v==='custom'){
    if(custom) custom.style.display='block';
    selAmount=null;
  } else {
    if(custom) custom.style.display='none';
    selAmount=v;
  }
}

function setFreq(f){
  donateFreq=f;
  document.querySelectorAll('.freq-btn').forEach(b=>b.classList.remove('on'));
  const el=document.getElementById('freq-'+f);
  if(el) el.classList.add('on');
}

/* ── DONATE — TAB SWITCH ──────────────────────────────────────── */
/* ── PAYSTACK ──────────────────────────────────────────────────── */
const PAYSTACK_KEY = 'pk_live_2ee1be5acbb3689353d2a46ed1b7bbb14a44fe4c';
const FALLBACK_USD_TO_GHS = 11.35; // only used if the live rate fetch fails

async function getLiveUsdToGhsRate(){
  try{
    const res = await fetch('https://open.er-api.com/v6/latest/USD');
    const data = await res.json();
    if(data && data.result==='success' && data.rates && data.rates.GHS){
      return data.rates.GHS;
    }
  }catch(e){
    console.warn('Live FX rate fetch failed, using fallback rate.', e);
  }
  return FALLBACK_USD_TO_GHS;
}

async function initPaystack(){
  const customEl=document.getElementById('d-custom');
  const amount=customEl&&customEl.style.display!=='none'?parseFloat(customEl.value):selAmount;
  const email=document.getElementById('d-email').value.trim();
  const name=document.getElementById('d-name').value.trim();
  const errEl=document.getElementById('d-err');
  const btn=document.querySelector('#pane-card .btn.bp');

  errEl.style.display='none';
  if(!amount||amount<1){errEl.textContent='Please select or enter a donation amount.';errEl.style.display='block';return;}
  if(!email||!email.includes('@')){errEl.textContent='Please enter a valid email address.';errEl.style.display='block';return;}

  if(!window.PaystackPop){
    alert('Payment system is loading. Please try again in a moment.');
    return;
  }

  const originalBtnText = btn ? btn.textContent : null;
  if(btn){btn.textContent='Getting current rate…';btn.disabled=true;}

  const liveRate = await getLiveUsdToGhsRate();
  const ghsAmount = Math.round(amount * liveRate);

  if(btn){btn.textContent=originalBtnText;btn.disabled=false;}

  const handler=window.PaystackPop.setup({
    key:PAYSTACK_KEY,
    email:email||'donor@kekeli4needy.com',
    amount:Math.round(ghsAmount*100),
    currency:'GHS',
    ref:'KCN-'+Date.now()+'-'+Math.floor(Math.random()*99999),
    metadata:{
      custom_fields:[
        {display_name:'Donor Name',variable_name:'donor_name',value:name||'Anonymous'},
        {display_name:'Frequency',variable_name:'frequency',value:donateFreq},
        {display_name:'USD Amount',variable_name:'usd_amount',value:'$'+amount},
        {display_name:'FX Rate Used',variable_name:'fx_rate',value:String(liveRate)},
        {display_name:'Fund Allocation',variable_name:'fund',value:document.getElementById('d-fund')?document.getElementById('d-fund').value:'Unrestricted'},
        {display_name:'Organisation',variable_name:'org',value:'Kekeli Co-operative For The Needy LBG'},
      ]
    },
    callback:function(response){
      document.getElementById('donateForm').innerHTML=`
        <div style="text-align:center;padding:24px 0">
          <div style="font-size:60px;margin-bottom:20px">🎉</div>
          <h3 style="font-family:'Instrument Serif',serif;color:var(--forest);font-size:24px;margin-bottom:10px">Thank You${name?', '+name:''}!</h3>
          <p style="color:var(--slate);font-size:15px;margin-bottom:8px">Your donation of <strong style="color:var(--forest)">$${amount.toLocaleString()} USD</strong> (charged as GHS ${ghsAmount.toLocaleString()}) has been received.</p>
          <p style="color:var(--slate);font-size:13px;margin-bottom:6px">Reference: <code style="background:var(--foam);padding:2px 8px;border-radius:4px">${response.reference||response.trxref}</code></p>
          <p style="color:var(--slate);font-size:13px;margin-bottom:24px">A receipt will be sent to <strong>${email}</strong>. Kekeli will acknowledge your donation within 48 hours.</p>
          <button class="btn bg" onclick="location.reload()">Make Another Donation</button>
        </div>`;
    },
    onClose:function(){console.log('Payment closed')}
  });
  handler.openIframe();
}

/* ── CONTACT FORM ──────────────────────────────────────────────── */
function submitContact(){
  const name=document.getElementById('cf-name').value.trim();
  const email=document.getElementById('cf-email').value.trim();
  const org=document.getElementById('cf-org').value.trim();
  const type=document.getElementById('cf-type').value;
  const msg=document.getElementById('cf-msg').value.trim();
  const errEl=document.getElementById('cf-err');
  const okEl=document.getElementById('cf-ok');
  const btn=document.getElementById('cf-submit');
  errEl.style.display='none'; okEl.style.display='none';
  if(!name||!email||!msg){errEl.textContent='Please fill in your name, email and message.';errEl.style.display='block';return;}
  if(!email.includes('@')){errEl.textContent='Please enter a valid email address.';errEl.style.display='block';return;}

  const originalText=btn.textContent;
  btn.textContent='Sending…';
  btn.disabled=true;

  fetch('https://formspree.io/f/xwvdwlww',{
    method:'POST',
    headers:{'Accept':'application/json','Content-Type':'application/json'},
    body:JSON.stringify({name:name,email:email,organisation:org,enquiry_type:type,message:msg})
  })
  .then(res=>{
    if(res.ok){
      okEl.style.display='block';
      document.getElementById('cf-name').value='';
      document.getElementById('cf-email').value='';
      document.getElementById('cf-org').value='';
      document.getElementById('cf-type').value='';
      document.getElementById('cf-msg').value='';
    } else {
      errEl.textContent='Something went wrong sending your message. Please try again or email us directly at info@kekeli4needy.com.';
      errEl.style.display='block';
    }
  })
  .catch(()=>{
    errEl.textContent='Something went wrong sending your message. Please try again or email us directly at info@kekeli4needy.com.';
    errEl.style.display='block';
  })
  .finally(()=>{
    btn.textContent=originalText;
    btn.disabled=false;
  });
}

/* ── SCROLL REVEAL OBSERVER ───────────────────────────────────── */
let revealObserver;
function observeReveals(){
  if(!revealObserver){
    revealObserver=new IntersectionObserver((entries)=>{
      entries.forEach(e=>{
        if(e.isIntersecting){e.target.classList.add('in');revealObserver.unobserve(e.target)}
      });
    },{threshold:.12,rootMargin:'0px 0px -40px 0px'});
  }
  document.querySelectorAll('.reveal:not(.in)').forEach(el=>revealObserver.observe(el));
}

/* ── NAV BACKGROUND ON SCROLL + PROGRESS ─────────────────────────── */
let lastScroll=0;
window.addEventListener('scroll',()=>{
  const navEl=document.getElementById('nav');
  if(window.scrollY>10){navEl.style.boxShadow='0 4px 24px rgba(0,0,0,.2)'}
  else{navEl.style.boxShadow='none'}
  const st=document.getElementById('scrollTop');
  if(window.scrollY>500){st.classList.add('show')}else{st.classList.remove('show')}
  updateScrollProgress();
},{passive:true});

/* ── ANIMATED COUNTERS ─────────────────────────────────────────── */
let counterObserver;
function animateCounter(el,target){
  if(el.dataset.done)return;
  el.dataset.done='1';
  const duration=1400;
  const start=performance.now();
  function step(now){
    const p=Math.min((now-start)/duration,1);
    const eased=1-Math.pow(1-p,3); // ease-out cubic
    const val=Math.floor(eased*target);
    el.textContent=val;
    if(p<1){requestAnimationFrame(step)}else{el.textContent=target}
  }
  requestAnimationFrame(step);
}
function observeCounters(){
  if(!counterObserver){
    counterObserver=new IntersectionObserver((entries)=>{
      entries.forEach(e=>{
        if(e.isIntersecting){
          const target=parseInt(e.target.dataset.target,10);
          animateCounter(e.target,target);
          counterObserver.unobserve(e.target);
        }
      });
    },{threshold:.4});
  }
  document.querySelectorAll('.cnum:not([data-done])').forEach(el=>counterObserver.observe(el));
}

/* ── COOKIE CONSENT ────────────────────────────────────────────── */
const COOKIE_CONSENT_DAYS = 180; // re-ask after this many days

function cookieChoice(choice){
  try{
    localStorage.setItem('kekeli_cookie_consent', JSON.stringify({choice:choice, ts:Date.now()}));
  }catch(e){}
  document.getElementById('cookieBanner').classList.remove('show');
}
function initCookieBanner(){
  let expired = true;
  try{
    const raw = localStorage.getItem('kekeli_cookie_consent');
    if(raw){
      const data = JSON.parse(raw);
      const ageMs = Date.now() - (data.ts || 0);
      const maxMs = COOKIE_CONSENT_DAYS * 24 * 60 * 60 * 1000;
      expired = ageMs > maxMs;
    }
  }catch(e){}
  if(expired){
    setTimeout(()=>document.getElementById('cookieBanner').classList.add('show'),900);
  }
}

/* ── HERO SLIDESHOW ────────────────────────────────────────────── */
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

/* ── LIGHTBOX ──────────────────────────────────────────────────── */
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
  initHeroSlideshow();
});