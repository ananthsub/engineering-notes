# Engineering Notes

Public visual explanations for pull request reviews and engineering design documents.

Published at <https://ananthsub.github.io/engineering-notes/>.

## Add a note

Drop static files anywhere in the repository. For example:

```text
pr-reviews/<owner>-<repo>/pr-<number>-<topic>.html
designs/<project>/<topic>/index.html
```

Commit and push the files:

```bash
git add .
git commit -s -m "docs: add <topic> note"
git push
```

On every push to `main`, the Pages workflow:

1. Copies HTML, PDF, image, CSS, JavaScript, JSON, and CSV files into the published site while preserving their paths.
2. Generates the site index automatically from every HTML and PDF file.
3. Lists documents newest-first using each file's latest Git commit time.
4. Deploys the result to GitHub Pages.

There is no source `index.html` to update.

## Cursor skills

The repository includes three Cursor skills:

- `pr-html-concise-public` creates a two-minute, one-page PR explanation.
- `pr-html-public` creates a full PR deep dive.
- `upload-public-html` checks, publishes, and verifies static pages.

Both review skills can ask the user to choose a topic, follow a specific code path, or turn a follow-up question into another page. They enforce the public-content policy before handing the result to the upload skill.

Install them as personal skills so they are available while working in other repositories:

```bash
./install_cursor_skills.sh
```

The installer creates symlinks under `~/.cursor/skills`. Pulling updates to this repository updates the installed skills immediately. Reload Cursor after the first installation.

Remove the symlinks with:

```bash
./uninstall_cursor_skills.sh
```

## Public-content warning

The repository and published site are public. Do not commit confidential source code, internal URLs, infrastructure details, credentials, customer data, unreleased information, or other sensitive material. Repository history and external archives may retain a file after deletion.
