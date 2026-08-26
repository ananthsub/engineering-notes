# Deep-dive quality bar

A deep dive earns its length. Each section must answer a different question that the reader needs to understand or review the change.

## Scope

- Follow one connected story through the PR.
- Explain behavior, not the order of files in the diff.
- Split unrelated mechanisms into separate pages.
- Prefer four to eight useful sections over exhaustive coverage.
- Keep the main HTML below roughly 100 KB unless embedded data or figures clearly justify more.

## First screen

The title, short answer, and first figure must explain:

- what changed;
- which object, request, or state moves;
- where the important decision occurs;
- why the reader should care.

Do not begin with repository history, motivation, or a table of contents.

## Diagrams

Each figure answers one named question.

Good figure subjects:

- an ownership boundary before and after;
- a request moving through concrete functions;
- queue or buffer contents at a failure point;
- a state machine with calls on transitions;
- configuration inputs and derived values;
- a timeline showing ordering and overlap.

Label real functions and values. Use pinned links. Put the legend beside the data it explains.

## Code explanation

Use real identifiers where they let readers find the code. Explain each identifier in plain words.

Prefer:

- a small excerpt with comments;
- pseudocode that preserves actual call order;
- a value trace showing state before and after each call;
- a compact mapping from responsibility to function.

Avoid:

- large copied diffs;
- syntax-highlighted code with no explanation;
- inventories of classes or files;
- claims supported only by the PR description.

## Worked examples

Use one small example across the document.

Before drawing:

1. list every configured value;
2. calculate every derived value;
3. replace inputs until each concept has a distinct number;
4. record the state at each important step.

Do not change values between sections merely to make a local diagram easier.

## Evidence

Separate three things:

- what the code does;
- what public evidence demonstrates;
- what remains untested or unknown.

Public before/after runs, failure reproductions, curves, and behavior-focused regression tests are useful. Generic passing checks are prerequisites, not proof.

## Review questions

A review question must include:

1. the concrete code behavior;
2. a realistic case where it matters;
3. the consequence;
4. the evidence or test that would resolve it.

Do not include style comments, vague risk language, or hypothetical problems with no path through the code.

## Language

Assume the reader knows the programming language but not the PR.

- Use short sentences.
- Introduce domain terms before relying on them.
- Keep one idea per sentence.
- Use active voice.
- Replace shorthand with what the code does.
- Explain cause before consequence.
- Remove words that sound precise but make the reader translate.

## Completion test

The page is ready only when a reader can:

- explain the changed mechanism without reopening the PR;
- point to the pinned code for each important step;
- replay the worked example;
- distinguish demonstrated behavior from inference;
- state the remaining review question, if any;
- read every figure on a phone in both themes;
- share the URL publicly without exposing private information.
