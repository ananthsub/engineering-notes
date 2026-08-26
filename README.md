# Engineering Notes

Visual explanations for pull request reviews, system behavior, and engineering design decisions.

Published at <https://ananthsub.github.io/engineering-notes/>.

## Add a note

Place each self-contained HTML document in a descriptive directory:

```text
pr-reviews/<project>/pr-<number>.html
designs/<topic>/index.html
```

Add a link to the document in `index.html`, then publish it:

```bash
git add .
git commit -m "docs: add <topic> note"
git push
```

GitHub Pages redeploys after every push to `main`.

Do not publish confidential source code, internal URLs, credentials, customer data, or other sensitive information.
