# Engineering Notes

Public visual explanations for pull request reviews and engineering design documents.

Published at <https://ananthsub.github.io/engineering-notes/>.

## Add a note

Drop static files anywhere in the repository. For example:

```text
pr-reviews/<project>/pr-<number>.html
designs/<topic>/index.html
```

Commit and push the files:

```bash
git add .
git commit -m "docs: add <topic> note"
git push
```

On every push to `main`, the Pages workflow:

1. Copies HTML, PDF, image, CSS, JavaScript, JSON, and CSV files into the published site while preserving their paths.
2. Generates the site index automatically from every HTML and PDF file.
3. Lists documents newest-first using each file's latest Git commit time.
4. Deploys the result to GitHub Pages.

There is no source `index.html` to update.

## Public-content warning

The published site is public. Do not commit confidential source code, internal URLs, credentials, customer data, or other sensitive information.
