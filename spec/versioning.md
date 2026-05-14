# Versioning

Specification version: `0.1.0-draft`

The INC specification version is separate from implementation package versions.
An implementation can support one or more specification versions.

## Version Form

Specification versions use semantic-version-like identifiers:

```text
MAJOR.MINOR.PATCH[-LABEL]
```

Examples:

- `0.1.0-draft`
- `0.1.0`
- `1.0.0`

## Compatibility

- A patch change SHOULD clarify wording, fix examples, or add non-breaking test
  coverage.
- A minor change MAY add optional behavior, new recommended conventions, or new
  tests that do not invalidate previously conforming files.
- A major change MAY alter normative syntax or conformance rules.

Implementations SHOULD state which INC specification version they target.
