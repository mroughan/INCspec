# Structure Section

This document is normative.

The optional `[structure]` section contains a small allowlist of CSV parsing
hints for the CSV component.

`[structure]` values use the ordinary metadata value rules.

Explicit reader arguments supplied by the caller MUST override values from
`[structure]`.

## Allowed Keys

Conforming readers MUST support the following `[structure]` keys:

| Key | Type | Meaning |
| --- | --- | --- |
| `delim` | character | Delimiter between CSV fields. |
| `delimiter` | character | Alias for `delim`. |
| `quotechar` | character | Quote character used by the CSV component. |
| `escapechar` | character | Escape character used by the CSV component. |
| `comment` | single-character string | Comment marker for CSV component lines. |
| `header` | integer | CSV component line containing column names. |
| `footerskip` | integer | Number of trailing CSV component rows to ignore. |

If both `delim` and `delimiter` are present, `delimiter` MUST take precedence.

Keys outside this allowlist MUST be rejected by conforming readers.

## Character Values

The character-valued keys are:

- `delim`;
- `delimiter`;
- `quotechar`;
- `escapechar`.

Character values MUST be one character after metadata parsing, except for the
special strings below.

Readers MUST recognize:

- `tab` as the tab character;
- `space` as the space character;
- `\t` as the tab character;
- an integer Unicode code point, such as `44` for comma.

Readers MUST reject character values that cannot be converted to a single
character.

## String Values

The string-valued keys are:

- `comment`.

Readers MUST reject non-string values for string-valued keys.

Readers MUST reject `comment` values that are not exactly one Unicode scalar
value after metadata parsing. For example, `comment = #` is valid, but
`comment = //` is not.

`comment` applies only to the CSV component. Metadata comments remain fixed as
`#` and `;`.

## Integer Values

The integer-valued keys are:

- `header`;
- `footerskip`.

Readers MUST reject string values for integer-valued keys, even if the string
looks like an integer.

Line-oriented values are relative to the CSV component after the closing
metadata delimiter.

## Non-Structure CSV Options

CSV parser options outside the allowlist are intentionally not part of
`[structure]`. Implementations MAY expose them as ordinary language-specific
reader arguments.

Examples of options that MUST_NOT be stored in `[structure]` for this
specification version include:

- `skipto`;
- `limit`;
- `missingstring`;
- `dateformat`;
- `normalizenames`;
- `ignoreemptyrows`;
- `ignorerepeated`;
- `decimal`;
- `groupmark`.

## Writing

Writers MUST_NOT infer or create `[structure]` metadata from writer keyword
arguments. If a file needs structure metadata, callers MUST provide it
explicitly as metadata.
