# One-page quality bar

The page should contain one question, one strong figure, one small worked example, and one clear consequence.

## Hard limits

- Length: one to two screens of scrolling.
- `<h2>` sections: no more than three.
- Figures: one for the problem; a second only when it explains the fix better than pseudocode.
- File size: aim below 25 KB.
- Table of contents: none.
- Lead: no more than five sentences.

If the page breaks a limit, split the topic into separate pages.

## The figure teaches before the prose

- Use inline SVG.
- Draw the real object: numbered prompts, queue slots, process states, bytes, calls, or a timeline.
- Use CSS variables for every color.
- Green means correct, red means the problem, and gray means ignored.
- Put the legend inside the figure beside the items it explains.
- Label every arrow with the call or transition that causes it.
- Wrap code references in clickable SVG `<a>` elements and underline the text. Phone readers cannot hover.
- Use pinned public permalinks.
- Balance every SVG tag.
- Check every label against the `viewBox`. Estimate text width as `character count × font size × 0.55` for sans text or `× 0.6` for monospace text. Account for `text-anchor`.
- Put long notes below the drawing and align them left. Do not squeeze them beside a marker.

Use a tight monospace trace only when the topic truly has no useful picture.

## The fix is concrete

Run the problem and fix on the same small values.

For pseudocode:

- use two to four short blocks;
- show actual values in comments at each step;
- link each block to the real code;
- align values so the reader can compare states without mental arithmetic.

For a second figure, apply the same source-link, color, legend, and bounds rules as the first.

## Evidence earns trust

Use the strongest public evidence that exists.

Do not use:

- a CI status table;
- a list of unit tests;
- “tests pass”;
- “the code compiles”;
- private evidence described without a public source.

A single regression test can count when it directly reproduces the old bug and proves the changed behavior.

When no public run exists, say what is missing and name the run or measurement a reviewer should request.

## Plain language

Assume the reader has not opened the PR or surrounding code.

- Use short sentences with one idea each.
- Use active voice.
- Define a domain term in the sentence where it first appears.
- Keep real code identifiers and explain them with plain comments.
- Replace shorthand learned from the diff with what the thing does.
- Remove throat-clearing such as “it is worth noting,” “importantly,” and “as we can see.”

Avoid words that make the reader translate:

| Avoid | Write |
|---|---|
| leverage | use |
| surface, as a verb | show |
| semantics | what it means |
| canonical | standard |
| idempotent | safe to run twice |
| pathological | worst case |
| degenerate | empty or all one value |
| elide | skip |
| obviate | make unnecessary |
| preclude | prevent |
| delta | difference |
| amortized | spread across many steps |
| by construction | because of how it is built |
| nuanced | there is a catch |

Read every figure label with zero context. Replace or explain any noun known only because the author read the diff.

## Final critic

Before upload, answer these questions:

1. Did the figure teach the main point before the prose?
2. Can the reader point to the code that implements the fix?
3. Does the page show public evidence, or clearly say that none exists?
4. Can a reader finish without looking up a word?
5. Does every code claim link to a pinned public line?
6. Are all worked-example quantities distinct, including derived values?
7. Does the page remain readable on a phone in both themes?
8. Is every fact safe to publish?

If any answer is no, revise before upload.
