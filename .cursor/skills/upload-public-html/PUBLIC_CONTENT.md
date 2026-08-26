# Public-content policy

The GitHub repository and Pages site are public. Search engines, archives, and repository history can retain a file after deletion. A later cleanup does not undo disclosure.

## Allowed by default

- Information already present in a public repository, issue, pull request, release, or documentation page.
- Public commit SHAs and permalinks.
- Public CI results and public benchmark results.
- General descriptions of published systems.
- Hardware names such as “H100” or “GB200” without private location or account details.

## Do not publish

- Tokens, keys, passwords, cookies, signed URLs, credentials, or secrets of any kind.
- Internal hostnames, IP addresses, cluster names, account names, regions, datacenters, mount paths, or infrastructure diagrams.
- Links to private GitLab, W&B, Grafana, dashboards, logs, documents, or source browsers.
- Internal Jira, Linear, incident, support, or ticket identifiers.
- Colleagues' names, email addresses, handles, comments, or review activity unless that identity is already part of the public source and is necessary to explain the public record.
- Unreleased model, product, feature, roadmap, customer, revenue, capacity, or performance information.
- Private metrics, run results, screenshots, logs, code, diffs, or configuration values.
- Personal data or customer data.

## Replace private detail with public-safe evidence

- Replace a cluster name with the public GPU model only when location is irrelevant.
- Replace an internal source link with a public permalink.
- Omit private run links. State that no public run evidence is available.
- Describe a private ticket only if the same fact is already public. Do not include its ID.
- Redraw a diagram from public code. Do not copy internal screenshots.

## Decision rule

Publish only when every claim and asset is supported by public information or the user explicitly confirms it is approved for public release.

When uncertain, stop. Ask whether to remove the detail or use the internal `nemo-html` workflow.
