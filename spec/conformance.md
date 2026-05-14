# Conformance

This document is normative.

## Reader Conformance

A conforming INC reader MUST:

- read UTF-8 INC files;
- support plain CSV passthrough with empty metadata;
- parse metadata according to [Metadata Syntax](metadata-syntax.md);
- preserve metadata value types as integer or string;
- reject malformed metadata described in [Errors And Warnings](errors-and-warnings.md);
- support all `[structure]` keys in [Structure Section](structure.md);
- apply `[structure]` options to the CSV component only;
- allow explicit reader arguments to override `[structure]`;
- support mini-schema reading and validation if the implementation claims schema
  support.

An implementation MAY provide a metadata-only parser, but it is not a complete
INC reader unless it also handles the CSV component.

## Writer Conformance

A conforming INC writer MUST:

- write UTF-8;
- write valid metadata syntax;
- reject invalid metadata names, values, and empty sections;
- quote and escape string values so they round-trip;
- write a metadata delimiter before and after the metadata block;
- write the CSV component using host-language CSV behavior.

Writers SHOULD use deterministic metadata ordering.

## Schema Conformance

An implementation claiming mini-schema support MUST:

- read canonical requirement sections;
- apply RFC 2119 aliases as read aliases, if aliases are supported;
- reject duplicate paths across requirement classes;
- reject paths deeper than one section level;
- validate `MUST`, `MUST_NOT`, `OPTIONAL`, and `allow_extra`.

## Test Conformance

An implementation SHOULD run the JSON schedules in `tests/`.

Passing the provided tests does not prove complete conformance, but failing a
normative test indicates a conformance issue unless the implementation clearly
documents that the relevant feature is unsupported.
