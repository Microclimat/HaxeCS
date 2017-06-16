# HaxeCS
Haxe Checkstyle - Happy Convention

The Haxe Checkstyle documentation : http://haxecheckstyle.github.io/docs/haxe-checkstyle/home.html

GitHub Repository : https://github.com/HaxeCheckstyle/haxe-checkstyle

## How to test our convention

First, you need to have neko installed and your node_modules downloaded.

Then, you can run manually the command

`neko node_modules/haxecheckstyle/run.n -s test/TestConvention.hx -c checkstyle.json`

Or juste execute `npm run test`


## Some of our convention specifications

- private members must contain an underscore at the begining of their name
- public members can't
- static member must be uppercase and can contain underscores
- tolerated method names:
    - common methods must only have numbers and letters
    - handlers (methods finishing by "Handler") can contain underscores in their name
- empty methods, classes, etc... must have brackets under format "{}"
- opening brackets must be on same line that the declaration. Examples:
    - if (condition) {
    - class MyClass {
- method "trace" will throw an error
- if/else nested max : 5
- cyclomatic complexity exceeding a score of 20 will throw a warning, a score of 25 is an error
- boolean tokens ("&&", "||", ...) must be on same line or at the beginning of the line
- max following empty lines : 1
- semilicons and commas must be followed by a space (or an end of line)
- array instantiations using the "new Array<T>()" are allowed and encouraged