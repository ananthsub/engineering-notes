---
name: pr-html-concise-public
description: One-page HTML explainer for a PR/MR — leads with a diagram, shows the evidence it works, in plain words. Uploads to my public github pages site.
argument-hint: "<pr-number> [the one thing to explain]"
user-invocable: true
---

# One-Page PR Explainer (public)

Make one page that tells a reader everything they need to know about one PR, or one question inside a PR. A reader should finish it in two minutes without needing another summary.

Default repository: `NVIDIA-NeMo/Gym`. Use the repository named by the user when provided.

Use `pr-html-public` when the question needs a full deep dive. Use this concise skill by default for one mechanism, one bug, one design choice, or one review finding.

## Public-only gate

Read the `PUBLIC_CONTENT.md` file from the `upload-public-html` skill before research.

Use this skill only when the page can exclude:

- cluster, cloud provider, account, region, and datacenter names;
- internal W&B, Grafana, dashboard, log, document, and GitLab links;
- internal Jira, Linear, incident, and ticket IDs;
- colleagues' names, emails, and handles;
- unreleased model, product, feature, roadmap, and metric information;
- private code, diffs, configuration, comments, and run results.

If any of those details are needed to tell the truth, use `AskQuestion` to offer:

1. remove or generalize the private detail;
2. use the internal `nemo-html` review skill; or
3. cancel.

Do not upload private material and do not offer a public override.

## Pick one question interactively

The page answers one question.

If the user supplied a specific question, restate it in plain words. Ask one focused clarification only when the scope or intended reader would change the page.

If the user supplied only a PR number:

1. Read the title, description, files, diff, comments, and public evidence.
2. Identify three to five concrete questions that would each make a useful page.
3. Use `AskQuestion` to let the user choose one. Put the strongest recommendation first.
4. Include an “Other” path so the user can name a different question.

Good questions describe behavior:

- How does the new owner prevent two workers from updating the same buffer?
- Why did checkpoint restore skip prompts?
- What happens to a request when one replica fails?

Do not use titles such as “PR 123 analysis” or “architecture overview.”

## Gather pinned public evidence

For GitHub:

```bash
gh pr view <number> --repo <owner>/<repo> \
  --json title,body,author,headRefOid,files,comments,reviews,url
gh pr diff <number> --repo <owner>/<repo>
gh pr checks <number> --repo <owner>/<repo>
```

Use `gh api` when review threads or check details are missing. For a public GitLab merge request, use `glab` and pin links to the merge request head SHA.

Do not use a GitLab MCP tool for code review. Do not expose facts merely because an authenticated tool can read them.

Store the full head SHA. Every code link must be a public permalink pinned to that SHA.

Read the changed code and its callers. Verify external API behavior against public source or documentation. Do not rely on the PR description when the code disagrees.

## Study the design bar

Read at least one of these pages before writing:

- <https://terrykong.github.io/gh-pages-poc/terryk/pr-3427-sc-ownership.html>
- <https://terrykong.github.io/gh-pages-poc/terryk/pr-3427-sc-samplers.html>
- <https://terrykong.github.io/gh-pages-poc/terryk/pr3429-cursor-advance.html>

Then read [QUALITY_BAR.md](QUALITY_BAR.md).

## Required page order

### Title

Use an `<h1>` that states what the reader will learn in words an engineer would say aloud.

### Provenance

Use one `<p class="sub">` line with the public PR link, related public issue links, and pinned head SHA. Never include a private ticket or source link.

### Lead

Explain the mechanism in three to five sentences. Link each code claim to the exact pinned line.

### Main figure

Use one inline SVG that carries the argument. A reader who sees only the figure should understand the problem.

Draw the specific state, data, or timeline. Do not use generic boxes when a concrete grid, queue, value trace, or sequence would teach more.

### Fix

Show how the fix works, not only the failure:

- use a second figure when order or ownership changed; or
- use two to four short pseudocode blocks with actual values and pinned links.

Use the same tiny worked example as the main figure.

### Does it work?

Show the strongest public evidence:

- performance: public before/after values with public hardware and configuration;
- convergence: a public curve or final metric against a public baseline;
- bug fix: the failing case and its fixed result;
- new configuration: a public end-to-end run;
- refactor: one behavior-focused regression test when it is the only direct evidence.

Green CI and a list of passing tests are not proof that the change works.

If no public run evidence exists, say so directly and state what evidence a reviewer should request. Do not mention a private run or link.

### Consequence

End with one `.warn` or `.hl` callout. In two to four sentences, state what breaks, improves, or needs reviewer action.

## Worked-example rule

List every input and derived value before drawing. Give each concept a distinct small value.

If two values collide, choose new inputs. The reader must be able to trace each number to one meaning. Apply the same rule to worker counts, steps, batches, and queue sizes.

## Build, critique, and upload

1. Read `HTML_STYLE.md` from the `upload-public-html` skill.
2. Start from the structure and visual density of the reference pages.
3. Write a self-contained HTML file.
4. Validate HTML, JavaScript, links, SVG balance, SVG bounds, mobile layout, and both themes.
5. Compare the page against the three references as if the author names were hidden.
6. Cut, redraw, and rewrite until this page is the one a tired engineer would choose to open.
7. Run the public-content review again.
8. Invoke `upload-public-html` with:

```text
pr-reviews/<owner>-<repo>/pr-<number>-<2-to-4-word-topic>.html
```

Do not report completion until the exact revision is live.

## Interactive follow-up

When the user asks to dive deeper after seeing the page:

1. Keep the same pinned SHA unless the PR changed and the user wants the latest revision.
2. Use `AskQuestion` to identify the desired direction: code path, worked example, evidence, edge case, or reviewer consequence.
3. Ask whether to replace the page, add a second concise page, or switch to `pr-html-public`.
4. Preserve the public-content gate for every follow-up.
