# Public HTML style

Generated pages must work as standalone documents on desktop and mobile.

## Theme

Use a dark theme by default and provide a persistent light/dark toggle. Drive every color, including SVG fills and strokes, through CSS variables.

```css
:root {
  --bg: #0d1117;
  --surface: #161b22;
  --border: #30363d;
  --text: #e6edf3;
  --dim: #8b949e;
  --accent: #58a6ff;
  --green: #3fb950;
  --red: #f85149;
  --gray: #6e7681;
}
:root[data-theme="light"] {
  --bg: #ffffff;
  --surface: #f6f8fa;
  --border: #d0d7de;
  --text: #1f2328;
  --dim: #59636e;
  --accent: #0969da;
  --green: #1a7f37;
  --red: #cf222e;
  --gray: #6e7781;
}
body {
  background: var(--bg);
  color: var(--text);
}
```

Apply the saved theme before the first paint:

```html
<script>
  (() => {
    try {
      if (localStorage.getItem("engineering-notes-theme") === "light") {
        document.documentElement.dataset.theme = "light";
      }
    } catch {}
  })();
</script>
```

Add a fixed toggle near the start of `<body>`. Its script must switch `data-theme` on the root element, update its visible label, and save the choice under `engineering-notes-theme`.

## Layout

- Set `<meta name="viewport" content="width=device-width, initial-scale=1">`.
- Keep the main wrapper at `max-width: 980px`.
- Use at least `16px` body text and comfortable line height.
- Make wide figures and tables scroll inside their own containers.
- Do not require hover to discover links or meaning.
- Keep touch targets large enough to use on a phone.

## Figures

- Prefer inline SVG for explanatory diagrams.
- Apply colors with classes that reference CSS variables.
- Underline linked labels. Wrap source references in SVG `<a>` elements.
- Put legends inside the figure.
- Use a `viewBox`; do not rely on fixed pixel width.
- Check every label against the viewBox because SVG text does not wrap.

## Source links

Use immutable public permalinks pinned to a full commit SHA. Links must be understandable without hover text.

## Dependencies

Prefer no remote dependencies. If one is necessary, use a stable public CDN and pin the version. Never load an asset from a private host.
