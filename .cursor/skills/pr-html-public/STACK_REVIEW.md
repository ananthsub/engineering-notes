# Stack and related-PR review

Use this guide when the deep dive covers more than one PR.

## Keep dependency and relationship edges separate

A stack is an ordered dependency chain. A related PR is not automatically part of that chain.

Classify every edge:

- **Depends on:** the child PR is based on the parent's head branch or commit.
- **Declared stack order:** the PR body or public stack metadata names the order, but current branch metadata no longer proves it.
- **Related:** the PRs solve adjacent parts of the same problem.
- **Overlaps:** both PRs change the same behavior or contract.
- **Supersedes:** one implementation replaces another.
- **Migration:** one PR converts existing data or configuration after another PR adds support.
- **Follow-up:** the later PR extends behavior without being required for the earlier PR to merge.
- **Uncertain:** public evidence suggests a relationship but does not prove its type.

Use solid arrows only for verified dependency edges. Use dashed or labeled connectors for every other relationship. Give each edge type a visible text label or distinct marker so color is never required. Put this legend inside the topology figure.

## Reconstruct topology carefully

For every PR, capture:

- number and state;
- base and head branch;
- full head SHA;
- merge commit and merge time when applicable;
- explicit “PR N of M,” “base,” and related-PR statements;
- public stack metadata when available.

Branch metadata can change after lower PRs merge or after a stack is retargeted. When today's base branch does not preserve the original chain:

1. inspect the PR body and timeline for explicit base declarations;
2. inspect commits and ancestry when the branches still exist;
3. compare the changed-file and commit sets;
4. label the result “declared order” rather than “verified dependency” when proof is incomplete.

Never invent missing stack members from numbering alone.

## Review unique layer diffs

Each PR should be reviewed against its own declared base. Build one layer record:

```text
PR | base → head | pinned SHA | unique behavior | public evidence | unresolved risk
```

Do not compare every PR head against the trunk. A higher PR contains lower-layer commits, so trunk comparisons repeat code and assign ownership to the wrong layer.

When a lower layer merged and a higher PR was retargeted, verify whether GitHub's PR diff still represents only the layer. If not, reconstruct the unique commit range and state how it was derived.

## Map cumulative behavior

Create a behavior ledger with one row per contract:

```text
Behavior | Before stack | First introduced | Later changed by | Final result
```

Useful contracts include:

- input or data shape;
- routing and precedence;
- ownership;
- validation timing;
- compatibility;
- migration;
- failure handling;
- output provenance;
- public evidence.

This ledger answers two questions that a PR-by-PR summary misses:

1. Which layer owns the behavior?
2. What does the complete stack do after all layers land?

## Compare related groups

When the user gives a primary stack and another related stack, create separate lanes in the topology figure.

Compare them by behavior, not by title:

- What problem does each group solve?
- Which contracts overlap?
- Does one group depend on, replace, or conflict with the other?
- Which group owns the final public interface?
- Can both merge without changing precedence or compatibility?
- Does one migration assume the other's behavior?

Do not call two groups one stack unless dependency evidence supports that claim.

## Required stack-page elements

### First-screen topology

Show:

- bottom-to-top order of each verified stack;
- PR number, short role, state, and abbreviated pinned SHA;
- solid dependency arrows;
- dashed related or overlap edges;
- a visible “you are here” marker when the user named one primary PR.

Use the high-contrast palette from `HTML_STYLE.md`, but distinguish lanes and states with labels, border styles, and markers too. The figure must teach the relationship before the prose and remain understandable in grayscale.

### Layer cards

Give each PR a compact section or card:

- what this layer adds;
- what it assumes from below;
- what later layers change;
- strongest public evidence;
- unresolved review question.

Keep inherited behavior out of the card.

### End-to-end figure

Trace one concrete object through the cumulative stack. For a data migration, show the object before preparation, after preparation, during runtime resolution, and in output provenance.

Label each transition with the PR that introduces it and a pinned code link.

### Relationship section

For related groups, show the shared behavior surface and state whether the relationship is dependency, overlap, replacement, migration, follow-up, or uncertain.

### Review order

Recommend an order:

1. foundational contracts;
2. consumers;
3. producers;
4. scaffolding or user interface;
5. migration and compatibility.

Adjust this order to the verified chain. Explain when a reviewer can review one layer independently and when a higher layer cannot be judged until a lower contract is settled.

## Evidence across a stack

Attribute evidence to the smallest scope it proves:

- a unit regression may prove one layer's precedence rule;
- a full pipeline replay may prove cumulative compatibility;
- a live end-to-end run may prove the complete stack;
- a migration inventory may prove only the migrated files, not runtime behavior.

Do not repeat one run under every layer. Do not claim stack-wide proof from a test that exercises only one PR.

## Force pushes and refreshes

Record the analysis time and every full head SHA.

Before publishing or updating:

1. fetch metadata again;
2. compare every current head SHA with the pinned ledger;
3. stop and ask whether to refresh if any open PR changed;
4. retain the old pins only when the user wants a historical snapshot.

Never mix code links from different revisions of one PR.

## Interactive follow-up

After presenting the stack map, let the user choose:

- one layer;
- one cross-layer contract;
- one relationship between groups;
- one failure or compatibility path;
- evidence for one claim;
- a concise page split from the deep dive.

Preserve the stack ledger and pinned SHAs so the follow-up does not silently shift revisions.
