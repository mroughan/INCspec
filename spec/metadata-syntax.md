# Metadata Syntax

This document is normative.

The metadata block is an INI-style, line-oriented syntax with a deliberately
small grammar.

## EBNF

```ebnf
metadata-block  = delimiter, newline,
                  { metadata-line, newline },
                  delimiter, newline ;

metadata-line   = blank-line
                | comment-line
                | section-header
                | property ;

blank-line      = whitespace ;

comment-line    = whitespace, comment-marker, { character } ;

section-header  = whitespace, "[", name, "]",
                  whitespace, [ inline-comment ] ;

property        = whitespace, name, whitespace, "=",
                  whitespace, value, whitespace,
                  [ inline-comment ] ;

inline-comment  = comment-marker, { character } ;

comment-marker  = "#" | ";" ;

value           = quoted-string
                | bare-value
                | empty ;

quoted-string   = '"', { quoted-character | escape-sequence }, '"' ;

escape-sequence = '\"' | '\\' ;

bare-value      = { non-newline-character } ;

name            = name-character, { name-character } ;

name-character  = any Unicode scalar value except:
                  whitespace, "[", "]", "=", "#", ";" ;

delimiter       = whitespace, dash, dash, dash, { dash }, whitespace,
                  [ inline-comment ] ;

dash            = any Unicode scalar value with General Category Pd ;

whitespace      = { " " | "\t" } ;
newline         = "\n" | "\r\n" ;
```

## Names

Names are used for top-level keys, section names, and section keys.

Names MUST be nonempty.

Names MUST_NOT contain:

- whitespace;
- `[`;
- `]`;
- `=`;
- `#`;
- `;`.

## Sections

Sections are one level deep.

A section header has the form:

```text
[section_name]
```

A section MUST contain at least one property before the next section header or
the closing metadata delimiter.

Duplicate section names MUST be rejected.

## Properties

A property has the form:

```text
key = value
```

Duplicate keys in the same scope MUST be rejected. A top-level key and a section
key with the same name are separate scopes.

## Values

Metadata values are limited to:

- integer values;
- string values.

Unquoted signed decimal integers MUST be read as integer values.

Quoted values MUST be read as strings, even if they look like integers.

All other bare values MUST be read as strings.

An empty value is allowed and MUST be read as the empty string.

## Quoting And Escaping

Quoted strings begin and end with `"`.

Inside quoted strings, the following escape sequences are recognized:

- `\"` for a literal double quote;
- `\\` for a literal backslash.

Backslash is an escape character only inside quoted strings. Outside quoted
strings it is ordinary text.

Writers MUST quote and escape string values containing `"` or `\`.

Writers MUST reject metadata string values containing newline characters `\n` or
`\r`.

## Comments

Metadata comments begin with `#` or `;`.

A full-line comment MAY appear anywhere in metadata.

Inline comments are comments only when the comment marker follows a nonempty
value and is separated from that value by whitespace.

Bare `#` and `;` values are allowed:

```text
comment = #
delim = ;
```

The `comment` key in `[structure]` affects only the CSV component. It does not
change metadata comment parsing.

## Deterministic Writing

Writers SHOULD write metadata in deterministic order:

1. top-level scalar keys, sorted by key;
2. sections, sorted by section name;
3. keys inside each section, sorted by key.

This ordering is recommended for reproducible files and stable tests.
