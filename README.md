# HaxeCS
Haxe Checkstyle - Happy Convention

This document lays out the coding standards for writing webapps in Haxe. Adhering to these standards makes the source code look consistent, well-organized, and professional.
Some of these standards are completely arbitrary, since there is not always a “best way” to code. Nevertheless, in the interest of consistency, all commits to any Haxe projects will be expected to follow these conventions.

The Haxe Checkstyle documentation : http://haxecheckstyle.github.io/docs/haxe-checkstyle/home.html

GitHub Repository : https://github.com/HaxeCheckstyle/haxe-checkstyle

## How to test our convention

First, you need to have neko installed and your node_modules downloaded.

Then, you can run manually the command

`neko node_modules/haxecheckstyle/run.n -s test/TestConvention.hx -c checkstyle.json`

Or juste execute `npm run test`

## Installation

This convention is available on NPM and can be added to your project as a dependency.

`npm install happyhxcs`

You should also install haxecheckstyle to use it.

`npm install haxecheckstyle`

### Intellij External Tools

You can create an External Tool to use this coding convention in your IDE. Configure it using this settings :

- Program : neko
- Parameters : node_modules/haxecheckstyle/run.n -c node_modules/happyhxcs/checkstyle.json -s $FilePath$
- Working directory : $ProjectFileDir$

You'll be able to right click on an hx file to run your external tool on it.


### Install a pre-commit hook

Add husky to your dependencies and your checkstyle script as a precommit command.

```json
  "scripts": {
    "precommit": "node ./scripts/pre-commit-checkstyle"
  },
  "devDependencies": {
    "husky": "0.14.1",
    "happyhxcs": ">=0.0.1",
    "haxecheckstyle": "2.1.12-dev.0"
  }
```
This is a precommit script exemple :

```javascript
console.log("pre commit haxe checkstyle");

var proc = require("child_process");


var command = "neko node_modules/haxecheckstyle/run.n -c node_modules/happyhxcs/checkstyle.json";
var options = {
    cwd: '.',
    encoding: 'utf8'
};

var files = proc.execSync('git diff -r -p -m -M --full-index --staged --name-only',options).split("\n");
var path = [];

for(var i = 0; i < files.length; i++){
    var file = files[i];
    if(file.indexOf('.hx') > 0 ){
        path.push('-s '+file);
    }
}

var checkstyleHandler = function(error, stdout, stderr){
    console.log(stdout);
    var r = new RegExp('Errors: ([0-9]*).*Warnings: ([0-9]*).*Infos: ([0-9]*)', "gim");
    var t = r.exec(stdout);
    var errors = parseInt(t[1]);
    var warnings = parseInt(t[2]);
    var infos = parseInt(t[3]);
    console.log("Errors : " + errors + " Warnings : " +warnings + " Infos : " + infos);
    if(errors > 0 || warnings > 0){
        console.warn("To many errors, fix before push");
        process.exit(1);
    }
}
if(path.length > 0) {
    proc.exec(command + ' ' + path.join(' '), options, checkstyleHandler);
}
```


# 1 Naming

Choosing good names is critical to creating code that is easy to use and easy to understand. You should always take the time to think about whether you have chosen the right name for something, especially if it is part of the public API.
Our naming standards are mostly based on Adobe standarts.

## 1.1 Abbreviations

Avoid them as a general rule. For example, calculateOptimalValue() is a better method name than calcOptVal().

Being clear is more important than minimizing keystrokes. And if you don't abbreviate, developers won't have to remember whether you shortened a word like “qualified” to “qual” or “qlfd”.

However, we have standardized on a few abbreviations:
- acc for accessibility, as in ButtonAccImpl
- auto for automatic, as in autoLayout
- auto for automatic, as in autoLayout
- eval for evaluate, as in EvalBindingResponder
- impl for implementation, as in ButtonAccImpl
- info for information, as in GridRowInfo
- num for number of, as in numChildren
- min for minimum, as in minWidth
- max for maximum, as in maxHeight
- nav for navigation, as in NavBar
- regexp for regular expression, as in RegExpValidator
- util for utility, as in StringUtil

This list probably does not include all abbreviations that are currently in use. If you're considering using an abbreviation that isn't listed here, please search the source code to determine whether it is already in use. If you don't find it, think twice about whether abbreviating is really appropriate.

Occasionally we are (deliberately) inconsistent about abbreviations. For example, we spell out “horizontal” and “vertical” in most places, such as horizontalScrollPolicy and verticalScrollPolicy but we abbreviate them to H and V in the very-commonly-used container names HBox and VBox.

## 1.2 Acronyms

Various acronyms are common Web developments, such as CSS, IME, UI, UID, URL, and XML.

An acronym is always all-uppercase or all-lowercase (e.g., URL or url, but never Url). The only time that all-lowercase is used is when the acronym is used by itself as an identifier, or at the beginning of an identifier, and the identifier should start with a lowercase letter. See the rules below for which identifiers should start with which case.

Examples of identifiers with acronyms are CSSStyleDeclaration, IUID, uid, IIME, and imeMode.

## 1.3 Word boundaries

When an identifier contains multiple words, we use two ways of indicating word boundaries: intercaps (as in LayoutManager or measuredWidth) and underscores (as in object_proxy). See the rules below for which method to use.

Sometimes it isn't clear whether a word combination has become its own single word, and we are unforunately inconsistent about this in some places: dropdown, popUp, pulldown.

Follow the acronym-casing rules even in the rare case that two acronyms must be adjacent. An example (which isn't actually in use) would be something like loadCSSURL(). But try to avoid such names.

## 1.4 Type-specifying names

If you want to incorporate the type into the name, make it the last “word”.
For example, name a border Shape border, borderSkin, or borderShape.

In the most of case, do not use the same name for an object as its type:

Do this:
```haxe
var validationButton:Button = new Button();
```

Not this:
```haxe
var button:Button = new Button();
```

## 1.5 Package names

Start them with a lowercase letter and use intercaps for subsequent words: controls, listClasses.

Package names should always be nouns or gerunds (the -ing noun form of a verb), not verbs, adjectives, or adverbs.
A package implementing lots of similar things should have a name which is the plural form of the thing: charts, collections, containers, controls, effects, events, formatters, managers, preloaders, resources, skins, states, styles, utils, validators.

It is common to use a gerund for the name of a package which implements a concept: binding, logging, messaging, printing. Otherwise, they are generally "concept nouns": accessibility, core, graphics, rpc.

## 1.6 File names

For importable APIs, the file name must be the same as the public API inside. But include files don't have to follow this rule.

Start the names of include files with an uppercase letter, use intercaps for subsequent words, and make the last word “Styles”: BorderStyles.hx, ModalTransparencyStyles.hx.
Start the names of individual asset files with a lowercase letter and use underscores between words: icon_align_left.png.

## 1.8 Interface names

Start them with I and use intercaps for subsequent words: IList, IFocusManager, IUID.

## 1.9 Class names

Start them with an uppercase letter and use intercaps for subsequent words: Button, FocusManager, UIComponent.

Name Event subclasses FooBarEvent.
Name Error subclasses FooBarError.
Name the EffectInstance subclass associated with effect FooBar FooBarInstance.
Name Formatter subclasses FooBarFormatter.
Name Validator subclasses FooBarValidator.

Name utility classes FooBarUtil (not FooBarUtils; the package is plural but the class is singular).
It is common to name a base class FooBarBase: ComboBase, DateBase, DataGridBase, ListBase.

## 1.10 Event names

Start them with a lowercase letter and use intercaps for subsequent words: "move", "creationComplete".

## 1.11 Style names

Start them with a lowercase letter and use intercaps for subsequent words: color, fontSize.

## 1.12 Enumerated values for String properties

Start them with a lowercase letter and use intercaps for subsequent words: "auto", "filesOnly", 

## 1.13 Constant names

Use all uppercase letters with underscores between words: OFF, DEFAULT_WIDTH.

The words in the identifier must match the words in the constant value if it is a String:

```haxe
public static inline var FOO_BAR:String = 'fooBar';
```

## 1.14 Property (variable and getter/setter) names

Start them with a lowercase letter and use intercaps for subsequent words: i, width, numChildren.
Use i for a loop index. Use j for an inner loop index.
```haxe
for (i in 0...10)
{
    for (j in 0...10)
    {
        ...
    }
}
```

Use the singular name of the list name for a for-in loop variable:
```haxe
for (item in _items)
{
    ...
}
```

## 1.15 Storage variable names

Give the storage variable for the getter/setter foo the name _foo.

## 1.16 Method names

Start them with a lowercase letter and use intercaps for subsequent words: measure(), updateDisplayList().
Method names should always be verbs.
Parameterless methods should generally not be named getFooBar() or setFooBar(); these should be implemented as getter/setters instead. However, if getFooBar() is a slow method requiring a large amount of computation, it should be named findFooBar(), calculateFooBar(), determineFooBar(), etc. to suggest this, rather than being a getter.

## 1.17 Event handler names

Event handlers should be named by concatenating “Handler” to the type of the event: mouseDownHandler().
If the handler is for events dispatched by a subcomponent (i.e., not this), prefix the handler name with the subcomponent name and an underscore: textInput_focusInHandler().

## 1.18 Argument names

Use value for the argument of every setter:

Do this:
```haxe
private function set_label(value:String):String
```

Not this:
```haxe
private function set_label(lab:String):String
```

Or this:
```haxe
private function set_label(labelValue:String):String
```

Or this:
```haxe
private function set_label(val:String):String
```

Use event (not e, evt, or eventObj) for the argument of every event handler:

```haxe
private function mouseDownHandler(event:Event):Void
```

# 2 Language Usage

This section discusses how we use the language constructs of Haxe, especially when there are multiple ways to express the same thing.

## 2.1 Type declarations

Use the narrowest type that is appropriate. 
For example, a mouseDownHandler should declare its argument as event:MouseEvent, not event:Event.

Use Dynamic only if the type is undefined.

## 2.4 Literals

### 2.4.2 Int literals

Use a lowercase x and uppercase A-Z in hexadecimal numbers.

Do this:
```haxe
0xFEDCBA
```

Not this:
```haxe
0xfedcba
```  

Always write an RGB color as a six-digit hexadecimal number.

Do this:
```haxe
private static inline var BLACK:Int = 0x000000;
```

Not this:
```haxe
private static inline var BLACK:Int = 0;
```

When dealing with indices, use the value -1 to mean “no index”.

### 2.4.3 Float literals

If a number value typically can be fractional, indicate this by using a decimal point, and follow the decimal point by a single trailing zero.

Do this:
```haxe
alphaFrom = 0.0;
alphaTo = 1.0;
```

Not this:
```haxe
alphaFrom = 0;
alphaTo = 1;
```

### 2.4.4 String literals

Use apostrophes (single quotes), not quotation marks (double quotes), to delimit strings.

Do this:
```haxe
'What\'s up, "Big Boy"?'
```

Not this:
```haxe
"What's up, \"Big Boy\"?"
```

Use \u, not \U, for unicode escape sequences.

### 2.4.5 Array literals

Use new Array<T>() rather than Array literals.

Do this:
```haxe
new Array<String>()
```

Not this:
```haxe
[]
```

### 2.4.7 Function literals

Avoid using function literals to define anonymous functions; use a class method or package function instead.

If you must use a function literal, declare a return type.

### 2.4.8 RegExp literals

Use the literal notation rather than constructing a EReg instance from a String.

Do this:
```haxe
var pattern = ~/haxe/i;
```

Not this:
```haxe
var pattern = new EReg("haxe", "i");
```

### 2.4.10 Class literals

Use a fully-qualified class literal only if necessary to disambiguate between two imported classes with the same unqualified name.

Do this:
```haxe
import mx.controls.Button;
...
var b:Button = new Button();
```

Not this:
```haxe
import mx.controls.Button;
...
var b:Button = new mx.controls.Button();
```

If a type or static field is used a lot in an importing module it might help to alias it to a shorter name. This can also be used to disambiguate conflicting names by giving them a unique identifier.

```haxe
import mx.controls.Button;
import my.controls.Button as MyButton;
...
var b:MyButton = new MyButton();
```

## 2.5 Expressions

### 2.5.1 Parentheses

Don't use unnecessary parentheses with common operators such as +, -, *, /, &&, ||, <, <=, >, >=, ==, and !=.

Do this:
```haxe
var e = a * b / (c + d);
```

Not this:
```haxe
var e = (a * b) / (c + d);
```

And this:
```haxe
var e = a && b || c == d;
```

Not this:
```haxe
var e = ((a && b) || (c == d));
```

The precedence rules for other operators are harder to remember, so parentheses can be helpful with them.

### 2.5.2 Coercion

Don't compare a Boolean value to true or false; it already is one or the other.

Do this:
```haxe
if (flag)
```

Not this:
```haxe
if (flag == true)
```

Do this:
```haxe
var flag = a && b;
```

Not this:
```haxe
var flag = (a && b) != false;
```

### 2.5.3 Comparison

Write comparisons in the order that they read most naturally:

Do this:
```haxe
if (n == 3) // "if n is 3"
```

Not this:
```haxe
if (3 == n) // "if 3 is n"
```

### 2.5.5 Ternary operator

Use a ternary operator in place of a simple if/else statement, especially for null checks.

### 2.6.2 import statements

Import specific classes, interfaces, and package-level functions rather than using the * wildcard.

### 2.6.3 return statements

Use only one return in a function.

Do this:
```haxe
var result=false;
if (!condition1)
    value = false;
...
if (!condition2)
    value =false;
...
if (!condition2)
    value = false;
...
return result;
```

Not this:
```haxe
if (!condition1)
    return false;
...
if (!condition2)
    return false;
...
if (!condition2)
    return false;
...
return true;
```

Do not enclose a return value in unnecessary parentheses.

Do this:
```haxe
return n + 1;
```

Not this:
```haxe
return (n + 1);
```

Returning from the middle of a method is OK.

### 2.6.4 if statements

Avoid using inline if statements.

Not this:
```haxe
if (flag)
    doThing1();
```
    
Do this:
```haxe
if (flag)
{
    doThing1();
}
```

Not this:
```haxe
if (flag)
    doThing1();
else
    doThing2():
```

 Do this:
```haxe
if (flag)
{
    doThing1();
}
else
{
    doThing2();
}
```

### 2.6.5 for statements

Make the body of a for loop be a block, even if it consists of only one statement.

Do this:
```haxe
for (i in 0...3)
{
   doSomething(i);
}
```

Not this:
```haxe
for (i in 0...3)
    doSomething(i);
```


## 2.7 Declarations

Don't declare multiple constants or variables in a single declaration.

Do this:
```haxe
var a:int = 1;
var b:int = 2;
```

Not this:
```haxe
var a:int = 1, b:int = 2;
```

### 2.7.1 The override keyword

If present, put this first, before the access specifier.

Do this:
```haxe
override private function measure():Void
```

Not this:
```haxe
private override function measure():Void
```

### 2.7.2 Access specifiers

Put an explicit access specifier everywhere that one is allowed. Do not use the fact that private is the implicit access specifier if none is written.
Before making an API public or private, think hard about whether it is really needs to be.

### 2.7.3 The static keyword

If present, put this after the access specifier.

Do this:
```haxe
public static inline var MOVE:String = 'move';
```

Not this:
```haxe
static public inline var MOVE:String = 'move';
```

### 2.7.5 Constants
All constants should be static. There is no reason to use an instance constant, since all instances would store the same value.
Put this before the var/function specifier.

Do this:
```haxe
public static inline var ALL:String = 'all';
```

Not this:
```haxe
inline public static var ALL:String = 'all';
```

### 2.7.6 Variables

If a variable needs to be initialized to a non-default value, do this in the declaration, not in the constructor.

Do this:
```haxe
private var _counter:Int = 1;
```

Not this:
```haxe
private var _counter:Int;
...
public function new()
{
    super();
    ...
    _counter = 1;
}
```

### 2.7.7 Local variables

Declare local variables at or just before the point of first use. Don't declare them all at the top of the function.

Do this:
```haxe
private function f(i:Int, j:Int):Int
{
    var a = g(i - 1) + g(i + 1);
    var b = g(a - 1) + g(a + 1);
    var c  = g(b - 1) + g(b + 1);

    return (a * b * c) / (a + b + c);
}
```

Not this:
```haxe
private function f(i:Int, j:Int):Int
{
    var a:Int;
    var b:Int;
    var c:Int;

    a = g(i - 1) + g(i + 1);
    b = g(a - 1) + g(a + 1);
    c = g(b - 1) + g(b + 1);
    return (a * b * c) / (a + b + c);
}
```

Declare local variables only one per function. ActionScript 3 doesn't have block-scoped locals.

Do this:
```haxe
var a:Int;
if (flag)
{
    a = 1;
    ...
}
else
{
    a = 2;
    ...
}
```

Not this:
```haxe
if (flag)
{
    var a:Int = 1;
    ...
}
else
{
    var a:Int = 2;
    ...
}
```

### 2.7.9 Constructors

If the constructor takes arguments that set instance vars, give the the same names as the instance vars.

Do this:
```haxe
public function new(foo:Int, bar:Int)
{
    this.foo = foo;
    this.bar = bar;
}
```

Not this:
```haxe
public function new(fooVal:Int, barVal:Int)
{
    foo = fooVal;
    bar = barVal;
}
```

Don't set the classes' instance vars in the constructor; do this in the declarations of the instance vars. However, if you need to reset the values of inherited instance vars, do this in the consturctor.

# 3 File Organization

This section presents the order in which an Haxe file should be organized.


# 4 Formatting

This section covers how an Haxe class should be formatted.

## 4.1 Line width

Wrap code to 80-character lines. This has the following advantages:
- Developers with smaller screens don't have to scroll horizontally to read long lines.
- A comparison utility can display two versions of a file side-by-side.
- The font size can be increased for projection before a group without requiring scrolling.
- The source code can be printed without clipping or wrapping.

## 4.2 Indentation

Use 4-tab indentation. Configure your text editor to insert tabs rather than spaces.

## 4.4 Separation of declarations

Use a single blank line as a vertical separator between function declarations.
Group variables and constants by visibility

```haxe
public static inline var MIN_WIDTH_PERCENT:Float = 0.15;
public static inline var MIN_HEIGHT_PERCENT:Float = 0.15;

public var area(get, set):Area;
public var showBorder(get, set):Bool;
public var highlight(get, set):Bool ;
public var mute(get, set):Bool;

private var _area:Area;
private var _backgroundShape:Shape;
private var _areaMask:Shape;
private var _border:Shape;
```
## 4.6 Array indexing

Don't put any spaces before or after the left bracket or before the right bracket.

Do this:
```haxe
a[0]
```

Not this:
```haxe
a[ 0 ]
```

## 4.7 Commas

Follow a comma with a single space. This applies to argument lists, array literals, and object literals.

## 4.8 Array literals

Put a single space after (but none before) each comma.

Do this:
```haxe
[1, 2, 3]
```

Not these:
```haxe
[ 1, 2, 3 ]
[1,2,3]
```

An empty array is a special case.

Do this:
```haxe
[]
```
Not this:
```haxe
[ ]
```

Format lengthy array initializers requiring multiple lines with aligned brackets:
```haxe
public static var numberNames:Array<String> =
[
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine"
];
```

## 4.9 Anonymous Structure literals
Put a single space after the colon separating the property name and value.

Do this:
```haxe
{a:1, b:2, c:3}
```

Not these:
```haxe
{a: 1, b: 2, c: 3}
{ a:1, b:2, c:3 }
{a:1,b:2,c:3}
```
An empty Object is a special case.

Do this:
```haxe
{}
```

Not this:
```haxe
{ }
```

Format lengthy object initializers requiring multiple lines with aligned braces:
```haxe
var textStyleMap =
{
    color: true,
    fontFamily: true,
    fontSize: true,
    fontStyle: true,
    fontWeight: true,
    leading: true,
    marginLeft: true,
    marginRight: true,
    textAlign: true,
    textDecoration: true,
    textIndent: true
};
```

## 4.11 Type declarations

Don't put any spaces before or after the colon that separates a variable, parameter, or function from its type.

Do this:
```haxe
var n:Float;
```

Not these:
```haxe
var n : Float;
var n: Float;
```

And this:
```haxe
function f(n:Float):Void
```

Not these:
```haxe
function f(n : Float) : Void
function f(n: Float): Void
```

## 4.12 Operators and assignments

Put a single space around the assignment operator.

Do this:
a = 1;

Not this:
a=1;

Put a single space around infix operators.

Do this:
a + b * c

Not this:
a+b*c

Put a single space around comparison operators.

Do this:
a == b

Not this:
a==b

Don't put any spaces between a prefix operator and its operand.

Do this:
!o

Not this:
! o

Don't put any spaces between a postfix operator and its operand.

Do this:
i++

Not this:
i ++
