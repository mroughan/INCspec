# Contributions

Contributions to INCspec are welcome. The goal is to keep the specification
small, portable, and easy to implement across languages.

## Ways To Contribute

- Report ambiguities, contradictions, or missing edge cases in the normative
  documents.
- Add or improve language-neutral fixtures in `fixtures/`.
- Add or improve JSON conformance schedules in `tests/`.
- Propose clarifications to informational documents and conventions.
- Report implementation experience from Julia, Python, JavaScript, or other
  language/tool integrations.

## Contribution Guidelines

- Keep normative changes narrow and explicit.
- Prefer examples and fixtures when a rule could be misunderstood.
- Avoid adding host-language-specific behavior to the portable format contract.
- Distinguish normative requirements from informational advice.
- Update `CHANGELOG.md` when a change affects the specification, fixtures, or
  conformance expectations.
- Update `SPEC_VERSION` only when the specification version itself changes.

## Review Expectations

Changes to normative files in `spec/` should be checked against:

- existing fixtures in `fixtures/`;
- machine-readable schedules in `tests/`;
- known implementations listed in `implementations.md`.

If a proposed change intentionally breaks compatibility, describe the reason and
the expected implementation impact.

## AI Assistance Disclosure

Contributors may use AI assistance, but submitted changes should be human
reviewed. Contributors are responsible for the accuracy, licensing suitability,
and maintainability of their submissions.
