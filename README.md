HUMON
=====

Humon is a human friendly object specification notation. Like JSON, but less annoying to type. 
*NOTE*: this is nowhere NEAR production ready. It was spun out of a personal project; updates pending.

HUMON parses down to json. It's based heavily off of the [coffee script grammar](http://coffeescript.org/documentation/docs/grammar.html)
with a few difference:
- string inference
- list inference

Coming soon:
- Date objects
- YAML compatability

Building
=======

- `cake makeParser` invokes jison to write the parser to `lib/parser.js`
- `cake build` removes all js from `lib/`, compiles javascript to `lib/`, and remakes the parser.
- `cake bundle` bundles humon.coffee into a single file (contains the lexer, parser, and recurser)

Tests
=====
- `npm test` to run tests (via jasmine-node)
