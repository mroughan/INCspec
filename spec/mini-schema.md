# Mini Schema

This document is normative.

The INC mini-schema is a lightweight way to describe required, forbidden, and
optional metadata fields. A schema is itself an INC file and uses the same
metadata syntax as ordinary INC files.

The mini-schema does not parse or enforce rich data types. Type descriptors are
strings intended for documentation and downstream tools.

## Requirement Sections

The canonical requirement sections are:

- `[MUST]`
- `[MUST_NOT]`
- `[OPTIONAL]`

The words follow IETF RFC 2119. `MUST_NOT` uses an underscore so the term fits
the INC section-name grammar.

Readers MAY accept these aliases:

| Canonical | Read aliases |
| --- | --- |
| `MUST` | `REQUIRED`, `SHALL` |
| `MUST_NOT` | `SHALL_NOT` |
| `OPTIONAL` | `MAY` |

Aliases are read-only conveniences. Writers SHOULD emit canonical section names.

## Schema Options

A schema MAY include a `[schema]` section.

Supported keys:

| Key | Type | Meaning |
| --- | --- | --- |
| `allow_extra` | string or integer | Whether fields outside the schema are allowed. |

`allow_extra` defaults to true.

The following values MUST mean false:

- `false`;
- `0`;
- `no`;
- `deny`;
- `closed`.

All other values SHOULD be treated as true.

## Descriptions

A schema MAY include a `[description]` section. It maps schema field paths to
human-readable descriptions.

Implementations MAY also accept `[descriptions]` as a read alias.

## Field Paths

Schema field paths MUST be either:

- top-level metadata names, such as `title`;
- one-level section paths, such as `columns.score`.

Paths deeper than one section level, such as `a.b.c`, MUST be rejected.

Each path component MUST satisfy the metadata name rules.

## Duplicate Requirements

A schema field path MUST appear in at most one requirement class.

Readers MUST reject schemas where the same path appears in more than one of:

- `MUST`;
- `MUST_NOT`;
- `OPTIONAL`;
- their aliases.

## Validation

Given metadata and a schema:

- a `MUST` field is valid only if the field path is present;
- a `MUST_NOT` field is valid only if the field path is absent;
- an `OPTIONAL` field may be present or absent;
- if `allow_extra` is false, fields outside the union of `MUST`, `MUST_NOT`,
  and `OPTIONAL` are invalid;
- if `allow_extra` is true, fields outside the schema are allowed.

Parent sections are considered known when any declared path uses that parent.
For example, declaring `columns.score` means the parent section `columns` is not
itself an extra field.

## Validation Result

Implementations SHOULD expose at least:

- whether validation succeeded;
- missing `MUST` paths;
- present `MUST_NOT` paths;
- extra paths when extras are not allowed.

Field names in result objects are implementation-specific.
