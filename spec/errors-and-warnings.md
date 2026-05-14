# Errors And Warnings

This document is normative unless marked as advice.

Conforming readers and writers MUST reject malformed input described in this
document. Exact exception classes, error names, and message text are
implementation-specific.

## Reader Errors

Readers MUST reject:

- a file beginning with an opening metadata delimiter but lacking a closing
  delimiter;
- malformed section headers;
- empty section names;
- invalid key or section names;
- duplicate section names;
- duplicate keys within the same scope;
- empty sections;
- metadata lines that are neither comments, section headers, nor properties;
- unsupported `[structure]` keys;
- `[structure]` values with the wrong type;
- schema paths deeper than one section level;
- schema paths with invalid path components;
- schema fields declared in more than one requirement class.

## Writer Errors

Writers MUST reject:

- metadata values whose type is outside the allowed value types;
- boolean values if the host language treats booleans as integers;
- metadata string values containing `\n` or `\r`;
- invalid key or section names;
- empty metadata sections.

Writers MUST quote and escape string values where needed for round-trip safety.

## Plain CSV

A file without an opening metadata delimiter MUST NOT be an error. Readers MUST
read it as plain CSV with empty metadata.

## Warnings

Implementations MAY warn when:

- a schema uses a read-only alias instead of a canonical requirement section;
- a file uses `delimiter` instead of `delim`;
- metadata contains extra fields while `allow_extra` is true;
- a caller-supplied CSV option overrides a value from `[structure]`.

Warnings MUST_NOT be required for conformance.

## Diagnostic Advice

Implementations SHOULD include useful context in parse errors, such as:

- path or stream name where available;
- metadata line number;
- offending key, section, or schema path.
