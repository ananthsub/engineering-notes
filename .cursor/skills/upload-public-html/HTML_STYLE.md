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
  --diagram-ok: #5bc0eb;
  --diagram-problem: #ffb000;
  --diagram-alt: #d98bc3;
  --diagram-neutral: #c7ced8;
}
:root[data-theme="light"] {
  --bg: #ffffff;
  --surface: #f6f8fa;
  --border: #d0d7de;
  --text: #1f2328;
  --dim: #59636e;
  --accent: #0969da;
  --diagram-ok: #005a8d;
  --diagram-problem: #9a4d00;
  --diagram-alt: #7a3e6d;
  --diagram-neutral: #4b5563;
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
- Use the shared blue/orange/purple/gray diagram palette. Do not use red and green as a semantic pair.
- Maintain at least 4.5:1 contrast between diagram marks or text and the background in both themes. The shared palette exceeds 6:1.
- Never communicate meaning through color alone. Pair color with visible text, a symbol, a shape, a border style, or a line pattern.
- Use blue plus a solid border for correct or active states. Use orange plus a warning symbol, hatched fill, or dashed border for problems. Use gray plus a muted label or dotted border for ignored states.
- Keep label text in `var(--text)` on `var(--bg)` or `var(--surface)`. Prefer colored outlines and markers over colored boxes with text inside them.
- Give chart series distinct point markers or line patterns in addition to different colors.
- Include the symbol, line, or shape encoding in the legend. The figure must remain understandable in grayscale.
- Underline linked labels. Wrap source references in SVG `<a>` elements.
- Put legends inside the figure.
- Use a `viewBox`; do not rely on fixed pixel width.
- Check every label against the viewBox because SVG text does not wrap.

## Source links

Use immutable public permalinks pinned to a full commit SHA. Links must be understandable without hover text.

## Dependencies

Prefer no remote dependencies. If one is necessary, use a stable public CDN and pin the version. Never load an asset from a private host.
