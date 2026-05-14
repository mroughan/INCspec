# Recommended Conventions

This document is informational.

These conventions are not required for INC conformance, but they are useful for
portable files and consistent implementations.

## File Extensions

Use `.inc` for INC files.

Use `.csv` for ordinary CSV files without metadata.

## Metadata Naming

Prefer lowercase ASCII names with underscores:

```text
publication_date = 2026-05-14
rights_holder = Example Lab
```

Unicode names are valid, but ASCII names are easier to use across command-line
tools and programming languages.

## Common Sections

Common section names:

- `[columns]` for column descriptions, units, or labels;
- `[structure]` for CSV parser hints;
- `[preservation]` for long-term management metadata;
- `[rights]` for licensing and access metadata;
- `[parameters]` for generating-code parameters;
- `[statistical]` for sample sizes and statistical qualities;
- `[process]` for processing or data generation notes.

## Dates

Store dates as strings unless an implementation explicitly interprets them.

Recommended forms:

```text
creation_date = "2026-05-14"
publication_date = "2026-05"
```

Quoting dates avoids accidental interpretation by tools that extend the base
metadata type system.

## Identifiers

Prefer stable identifiers when available:

```text
identifier = doi:10.0000/example
```

## Structure

Use `[structure]` only for the documented allowlist.

Pass uncommon or implementation-specific CSV options directly to the reader in
the host language rather than storing them in the file.

## Deterministic Writing

Writers should sort metadata keys and sections for readable diffs and stable
round-trip tests.
