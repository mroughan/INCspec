# Implementation Guide

This document is informational.

## Reader Sketch

1. Read the input as UTF-8 text.
2. If the first line is not a metadata delimiter, parse the whole file as CSV
   and return empty metadata.
3. If the first line is a delimiter, collect metadata lines until the next
   delimiter.
4. Parse metadata lines.
5. Convert `[structure]` metadata into CSV parser options.
6. Apply caller-supplied options, overriding `[structure]`.
7. Parse the CSV component.
8. Return metadata plus table data.

## Writer Sketch

1. Validate metadata names, sections, and values.
2. Reject empty sections.
3. Serialize metadata deterministically.
4. Quote and escape string values as needed.
5. Write opening delimiter, metadata lines, closing delimiter.
6. Write the CSV component using the host language's CSV writer.

## Schema Validator Sketch

1. Read the schema as an INC file.
2. Merge canonical requirement sections and accepted aliases.
3. Validate schema field paths.
4. Reject duplicate field paths across requirement classes.
5. Build field paths from the target metadata.
6. Check missing `MUST` fields.
7. Check present `MUST_NOT` fields.
8. Check extras when `allow_extra` is false.

## Interoperability Advice

Implementations should run the shared fixtures in `fixtures/` and the schedules
in `tests/`.

When host-language CSV behavior differs, prefer documenting the difference over
quietly extending `[structure]`.
