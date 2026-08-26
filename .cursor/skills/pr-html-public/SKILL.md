---
name: pr-html-public
description: Create and publish a public deep-dive HTML review of one PR, a dependent PR stack, or related PR groups, with pinned source evidence, topology diagrams, layer-by-layer behavior, validation evidence, and reviewer questions.
argument-hint: "<pr-number-or-url>... [related PRs] [topic or review question]"
user-invocable: true
---

# PR Deep Dive (public)

Create a public HTML deep dive that lets an engineer understand one pull request or a connected group of pull requests, trace the implementation, judge the evidence, and identify the decisions that still need review.

Default repository: `NVIDIA-NeMo/Gym`. Use another repository when the user names it.

Use `pr-html-concise-public` when one question fits in a two-minute page. Use this skill when the explanation needs several connected mechanisms, multiple figures, a full path from entry point to outcome, or relationships across PR layers.

## Public-only gate

Read the `PUBLIC_CONTENT.md` file from the `upload-public-html` skill before research.

The final page must contain only public information. Authenticated access does not make information publishable.

If the explanation needs internal infrastructure, private source links, private runs, internal tickets, colleagues' identities, unreleased work, or private metrics, use `AskQuestion` to offer:

1. narrow the page to public facts;
2. use the internal `nemo-html` deep-dive skill; or
3. cancel.

Never offer a public override for private information.

## Define the deep dive interactively

Do not turn a large PR into a file-by-file survey.

If the user gives a specific topic, state the question and the boundary. Ask a clarification only when audience, scope, or desired evidence would materially change the result.

If the user gives only a PR number:

1. Read enough of the PR to map its major mechanisms, behavior changes, and review risks.
2. Present three to five possible deep dives with `AskQuestion`.
3. Recommend the option that best explains the PR's central behavior.
4. Allow multiple selections only when the topics form one connected story.

Useful scope choices include:

- the full request or data path;
- state ownership and lifecycle;
- checkpoint, recovery, or failure behavior;
- concurrency and ordering;
- configuration flow and derived values;
- validation evidence and remaining uncertainty.

Ask who the page is for only when it changes the explanation: a reviewer, an implementer, or an operator.

## Accept single PRs, stacks, and related groups

Treat the user's arguments as one of these modes:

- **Single PR:** one PR number or URL.
- **Explicit stack:** several PRs listed in dependency order.
- **Discover stack:** one PR plus a request such as “review the stack.”
- **Related groups:** one stack or PR set plus another set described as related, alternative, earlier, superseded, or overlapping.

When the user provides several PRs, preserve the grouping and relationship they stated. Do not flatten every PR into one linear stack.

When the user asks to discover the stack:

1. Read the PR's base branch, head branch, body, linked PRs, and stack metadata when public.
2. Follow explicit base links and “PR N of M” declarations in both directions.
3. Present the discovered order with `AskQuestion` before doing a large review.
4. Let the user add missing PRs or mark a group as related rather than dependent.

If the user provides an explicit ordered stack, verify the order. Do not silently reorder it. Show any mismatch and ask whether to use the declared order or the verified branch chain.

For related groups, use `AskQuestion` after the relationship map is built. Offer focused review directions such as:

- end-to-end behavior across the primary stack;
- what each layer adds;
- how the related group overlaps or conflicts;
- which implementation owns the final behavior;
- compatibility and migration order;
- unresolved cross-PR review risks.

## Gather and verify

For GitHub:

```bash
gh pr view <number> --repo <owner>/<repo> \
  --json number,title,body,state,isDraft,baseRefName,headRefName,headRefOid,mergeCommit,mergedAt,files,comments,reviews,url
gh pr diff <number> --repo <owner>/<repo>
gh pr checks <number> --repo <owner>/<repo>
```

Run the metadata command for every PR. Fetch diffs and checks only after the scope is chosen. Batch independent reads when possible.

Use `gh api` for review threads, commits, and check details. For a public GitLab merge request, use `glab` and pin all source links to its head SHA.

Do not use a GitLab MCP tool for code review. Do not copy private source or comments into a public page.

Verify the PR against:

- changed code;
- callers and downstream consumers;
- the closest implementation already in the repository;
- tests that assert changed behavior;
- public documentation for external APIs;
- public run or benchmark evidence.

Store a full head SHA for every PR. Each code link must use the SHA of the PR layer that contains that code. Never use one stack-wide SHA.

For a stack or related groups, read [STACK_REVIEW.md](STACK_REVIEW.md) and build a private PR ledger before reviewing code. Record:

- PR number, title, state, and public URL;
- base branch, head branch, and full head SHA;
- verified dependency parent, if any;
- the behavior introduced by this layer;
- files and tests unique to this layer;
- public evidence attributable to this layer;
- explicit related, overlapping, superseding, or migration links.

Use a dependency edge only when branch metadata, commit ancestry, public stack metadata, or an explicit PR declaration supports it. Use a separate related-work edge for mentions or conceptual overlap. Mark uncertain edges as uncertain.

Review each PR's own diff against its declared base. Do not review every head against `main`: that counts inherited changes repeatedly and hides which layer introduced a behavior.

## Build a reader's map before writing

Draft a private outline containing:

1. the one-sentence answer;
2. the old behavior;
3. the new behavior;
4. the end-to-end path;
5. the state or values that change at each step;
6. the strongest public evidence;
7. concrete risks or unanswered review questions.

Remove any section that does not help the chosen scope.

For a stack, also record:

8. the verified bottom-to-top order;
9. the cumulative behavior after each layer;
10. cross-layer contracts and assumptions;
11. related work that overlaps without being a dependency.

## Required document shape

Read `HTML_STYLE.md` from the `upload-public-html` skill and [DEEP_DIVE_BAR.md](DEEP_DIVE_BAR.md). For multiple PRs, also apply [STACK_REVIEW.md](STACK_REVIEW.md).

### Title and provenance

Use a plain-language `<h1>` that states what the deep dive explains. Follow it with public PR links and pinned head SHAs. A stack page may use a compact provenance block instead of forcing every PR into one line.

### Answer first

Open with a short answer and a primary diagram. The first screen must teach the central mechanism without requiring the table of contents.

### Navigation

Add a compact table of contents for pages with more than three sections. Use descriptive section titles.

### Before and after

Show what changed in behavior. Prefer one aligned figure over separate lists.

For a stack, show the behavior before the bottom PR and after the top PR. Then make each intermediate layer's contribution visible.

### End-to-end path

Trace one concrete request, batch, object, or state transition through real functions. Label arrows with calls and pinned source links.

### Implementation

Group code by responsibility, not by file order. Explain what each piece does and why another piece depends on it.

Use short excerpts or pseudocode with value traces. Do not paste large diffs.

For a stack, attribute each mechanism to the first layer that introduces it. Explain later modifications where they occur. Do not repeat inherited code under every PR.

### Worked example

Choose small values that expose the interesting case. Keep all inputs and derived values distinct. Reuse the same values across figures and traces.

### Evidence

Show the strongest public run, before/after result, regression case, or behavior-focused test. Green CI alone is not evidence.

If no public run exists, say what is missing and what a reviewer should request. Do not hint at private evidence.

### Review questions

Include only concrete, evidence-backed concerns:

- behavior that the code leaves undefined;
- an untested failure or boundary case;
- mismatch between the PR claim and implementation;
- missing public validation;
- a compatibility or rollout requirement.

For each question, explain the consequence and point to the relevant pinned code. Do not invent concerns to fill a section. Write “No unresolved issue found in this scope” when appropriate.

### Consequence

End with what the change means for a reviewer, user, or operator. Keep this practical.

## Visual rules

- Use two to five figures when each answers a different question.
- Every figure must be understandable without hover.
- Use CSS variables for all HTML and SVG colors.
- Put legends inside figures.
- Make code links visible, underlined, and pinned.
- Draw real queue slots, values, calls, timelines, or ownership boundaries.
- Avoid generic architecture boxes unless system boundaries are the point.
- Check SVG tag balance and every text label against the `viewBox`.
- Make wide content scroll safely on a phone.

## Self-review

Before upload:

1. Read the page from top to bottom as someone unfamiliar with the PR.
2. Remove repeated prose and every section that merely lists files.
3. Check that each diagram makes a claim and each claim has a pinned source.
4. Verify that the fix receives as much attention as the problem.
5. Separate public evidence from inference.
6. Test mobile layout, theme switching, links, JavaScript, HTML, and SVG bounds.
7. Run the public-content review on the final source and assets.
8. Compare the first screen with the concise reference pages. The deep dive may be longer, but it must teach as quickly.

## Upload

Invoke `upload-public-html` with:

```text
pr-reviews/<owner>-<repo>/pr-<number>-<2-to-4-word-topic>-deep-dive.html
```

For a stack or related PR groups, use:

```text
pr-reviews/<owner>-<repo>/stacks/pr-<bottom>-<top>-<2-to-4-word-topic>.html
```

Do not report completion until the exact revision is live.

## Interactive follow-up

Treat the first page as a map, not the end of the conversation.

When the user asks a follow-up:

1. Answer from the pinned source when possible.
2. Use `AskQuestion` when several deeper paths are useful: code trace, state lifecycle, failure case, configuration arithmetic, evidence, reviewer risk, one stack layer, or a cross-stack relationship.
3. Ask whether to update the deep dive or create a separate one-page explainer with `pr-html-concise-public`.
4. Keep the same pinned SHAs unless the user asks to refresh the analysis.
5. Re-run the public-content gate before publishing any update.
