# Specification Repository Structure

This document is informational.

The INC specification repository uses this layout:

```text
INCspec/
  SPEC_VERSION
  README.md
  spec/
    conformance.md
    errors-and-warnings.md
    file-format.md
    metadata-syntax.md
    mini-schema.md
    repository-structure.md
    structure.md
    versioning.md
  fixtures/
    positive/
    negative/
    roundtrip/
  tests/
    manifest.json
    positive.json
    negative.json
    roundtrip.json
  conventions/
    recommended-conventions.md
  informational/
    csv-options-rosetta.md
    goals-and-non-goals.md
    implementation-guide.md
  scripts/
```

Normative format rules live in `spec/`. Test data lives in `fixtures/`.
Machine-readable test schedules live in `tests/`.

The `informational/` and `conventions/` directories are not normative unless a
normative document explicitly incorporates them.
