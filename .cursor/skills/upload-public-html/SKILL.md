---
name: upload-public-html
description: Upload HTML explainers and their static assets to Ananth's public engineering-notes GitHub Pages site. Use when publishing a visualization, PR explanation, or design document to the public site.
argument-hint: "<html-path> [destination path]"
user-invocable: true
---

# Upload Public HTML

Publish static content to <https://ananthsub.github.io/engineering-notes/>.

The repository is public. The deployed site is public. Treat every file in the repository as readable by anyone on the internet.

## Stop before touching the repository

Read [PUBLIC_CONTENT.md](PUBLIC_CONTENT.md). Inspect the HTML and every linked local asset.

If any content may be private, use `AskQuestion` to ask whether the user wants to:

1. remove or replace the private content;
2. publish to the internal `nemo-html` site instead; or
3. cancel.

Do not offer “publish anyway” as a choice. An explicit request to use this skill is not clearance to expose private data.

## Repository and URLs

- Local repository: `~/dev/engineering-notes`
- GitHub repository: `ananthsub/engineering-notes`
- Site root: `https://ananthsub.github.io/engineering-notes/`

If the local repository is missing, clone it:

```bash
git clone https://github.com/ananthsub/engineering-notes.git ~/dev/engineering-notes
```

Before editing, inspect `git status`. Do not overwrite or include unrelated work. Pull with `git pull --ff-only` only when the worktree is clean.

## Choose the destination

Use these defaults:

```text
pr-reviews/<owner>-<repo>/pr-<number>-<2-to-4-word-topic>.html
designs/<project>/<2-to-4-word-topic>/index.html
```

Keep supporting assets beside the page when practical:

```text
pr-reviews/nvidia-nemo-gym/pr-123-buffer-ownership.html
pr-reviews/nvidia-nemo-gym/pr-123-buffer-ownership.css
pr-reviews/nvidia-nemo-gym/pr-123-buffer-ownership-data.json
```

Do not place a generated page at the repository root. The deployment workflow creates the root index.

If a file already exists at the destination and the user did not clearly ask to replace it, use `AskQuestion` before changing it.

## Prepare the page

Copy or write the HTML and all local assets into the destination directory. Use relative asset links.

For generated HTML:

- Read [HTML_STYLE.md](HTML_STYLE.md).
- Make the page self-contained unless a separate local asset makes review easier.
- Do not load scripts, fonts, styles, or images from private hosts.
- Pin public source links to immutable commit SHAs.
- Include no analytics, tracking scripts, or comment widgets.

## Public-content review

Read the rendered text and source. Search the HTML and assets for likely leaks, including:

- credentials, bearer tokens, API keys, signed URLs, and cookies;
- absolute home, mount, cache, or cluster paths;
- private hostnames and non-public domains;
- cluster, cloud account, region, or datacenter names;
- internal W&B, Grafana, dashboard, GitLab, Jira, or Linear links and IDs;
- colleagues' names, email addresses, and chat handles;
- unreleased products, models, features, roadmaps, and private metrics.

Searches only catch obvious leaks. Judge the meaning of the page as well.

If the page comes from a private PR or internal source, require explicit confirmation that the facts shown are approved for public release. If that approval is missing, redirect to the internal upload skill.

## Validate

Before committing:

1. Open or parse the HTML and confirm it has a title and a viewport declaration.
2. Validate that inline JavaScript parses.
3. Check that HTML and SVG tags are balanced.
4. Confirm every relative link resolves to a file that will be committed.
5. Check the page at a phone-sized viewport when browser tools are available.
6. For SVG, confirm every text label fits inside its `viewBox`.
7. Confirm dark and light themes keep all text, code, lines, markers, and SVG labels at high contrast.
8. Check diagrams in grayscale. Confirm labels, shapes, symbols, borders, or line patterns preserve every distinction without color.
9. Re-run the public-content review on the final files.

Do not publish a page with a known validation failure.

## Commit and deploy

Stage only the new page and its assets. Review the staged diff before committing.

```bash
cd ~/dev/engineering-notes
git add <destination files>
git commit -s -m "docs: add <topic> explainer"
git pull --rebase
git push
```

If unrelated local changes prevent a safe rebase or push, stop and report the conflict. Do not stash, discard, or include someone else's changes.

GitHub Actions rebuilds the index and deploys the site after every push to `main`.

## Verify before sharing

Wait for the exact pushed commit's Pages workflow:

```bash
RUN_ID=$(gh run list --repo ananthsub/engineering-notes --commit "$(git rev-parse HEAD)" \
  --workflow pages.yml --json databaseId --jq '.[0].databaseId')
gh run watch "$RUN_ID" --repo ananthsub/engineering-notes --exit-status
```

Then fetch the final URL until both conditions hold:

- HTTP status is `200`;
- the response contains a string unique to this revision.

Check every uploaded asset too. Do not hand the user a URL that is missing, stale, or backed by a failed workflow.

Return:

- the live page URL;
- the repository path;
- the commit SHA;
- any evidence that could not be made public and was therefore omitted.
