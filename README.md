HUMON
=====
Humon is a human friendly object specification notation. Like JSON, but less annoying to type

Building
=======
`cake makeParser` invokes jison to write the parser to `lib/parser.js`
`cake build` removes all js from `lib/`, compiles javascript to `lib/`, and remakes the parser.
`cake browserify` packages the parser js file.

Tests
=====
`npm test` to run tests (via jasmine-node'
