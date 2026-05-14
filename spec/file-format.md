# File Format

This document is normative.

An INC file is a UTF-8 text file containing an optional metadata block followed
by a CSV component.

## File Model

An INC file has one of two forms:

```text
metadata-delimiter
metadata-lines
metadata-delimiter
csv-component
```

or:

```text
csv-component
```

If a file does not begin with a metadata delimiter, a conforming reader MUST
treat it as plain CSV with empty metadata.

## Encoding

INC files MUST be encoded as UTF-8.

Writers MUST write UTF-8.

Readers SHOULD reject input that is not valid UTF-8.

## Metadata Delimiter

The default metadata delimiter is three ASCII hyphen-minus characters:

```text
---
```

A delimiter line MUST contain three or more consecutive Unicode characters in
General Category `Pd` (`Punctuation, Dash`), allowing leading and trailing
whitespace.

After the dash run, a delimiter line MAY contain a metadata-style comment
beginning with `#` or `;`.

Examples of valid delimiter lines:

```text
---
----
   ---   
--- # metadata starts
———
```

The dash characters MUST be consecutive. A line such as `- - -` is not a
delimiter.

Delimiter-like text may appear inside metadata values because only complete
delimiter lines terminate the metadata block. For example:

```text
key = "this is not a delimiter ---"
```

## CSV Component

The CSV component starts immediately after the closing metadata delimiter. It is
ordinary delimiter-separated tabular text.

This specification does not redefine CSV. Implementations MUST use their host
language's CSV parser, or behavior compatible with it, for the CSV component.

The `[structure]` metadata section MAY provide a small allowlist of CSV parsing
hints. See [Structure Section](structure.md).

## Plain CSV Passthrough

If no opening metadata delimiter is present on the first line, readers MUST
return empty metadata and parse the whole file as CSV.

This creates an intentional ambiguity between a plain CSV file and an INC file
with no metadata block. Implementations are not required to expose a separate
flag distinguishing these cases.
