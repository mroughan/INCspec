# Fixtures

This directory contains shared INC test fixtures.

## Positive Fixtures

Files in `positive/` are valid. Conforming readers should parse them
successfully.

They cover:

- basic metadata;
- plain CSV passthrough;
- `[structure]` delimiter, quote, escape, header, and footer options;
- metadata comment markers used as literal values;
- quoted escape sequences;
- UTF-8 metadata and CSV content;
- mini-schema validation.

## Negative Fixtures

Files in `negative/` are intentionally invalid. Conforming readers or schema
readers should reject them.

They cover:

- missing closing delimiters;
- empty sections;
- invalid names;
- repeated keys;
- unsupported `[structure]` keys;
- `[structure]` values with wrong types;
- invalid schema paths;
- duplicate schema requirements.

## Roundtrip Fixtures

Files in `roundtrip/` are canonical expected outputs for writer tests.

Implementations may differ in CSV quoting style for some edge cases. The
round-trip schedule therefore uses small examples where canonical output is
intended to be stable.
