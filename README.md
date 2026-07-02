# Kekeli Co-operative For The Needy LBG — Website

Official website for Kekeli Co-operative For The Needy LBG, Akatsi, Volta Region, Ghana.

## Structure

```
index.html      — main site (single-page, continuous scroll + click-through deep pages)
css/style.css   — all styles
js/main.js      — navigation, scroll behaviour, donation flow, form handling
images/         — logo, favicon, apple-touch-icon (real photos to be added under this folder)
```

## Local preview

Open `index.html` directly in a browser, or serve locally:

```bash
python3 -m http.server 8080
```

Then visit `http://localhost:8080`.

## Deployment

Deployed via Cloudflare Pages, connected to this repository. Every push to `main` triggers an automatic redeploy.

## Notes

- Donation flow uses a live Paystack key (`js/main.js`) — real transactions process immediately.
- Contact form (`submitContact()` in `js/main.js`) currently only validates client-side. Needs a backend (Formspree/Netlify Forms/serverless function) wired in before go-live.
- `og:image` meta tag in `index.html` points to `https://kekeli4needy.com/assets/kekeli-og-image.png` — must be uploaded to that path (or updated to match final hosting) for social share previews to work.
- Photo placeholders (`.ph` / `.pht` divs) throughout `index.html` are marked "Photo Placeholder" — real photos should be added to `images/` and referenced to replace them.

© 2026 Kekeli Co-operative For The Needy LBG
