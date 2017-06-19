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
```var validationButton:Button = new Button();```

Not this:
```var button:Button = new Button();```

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

```public static inline var FOO_BAR:String = 'fooBar';```

## 1.14 Property (variable and getter/setter) names

Start them with a lowercase letter and use intercaps for subsequent words: i, width, numChildren.
Use i for a loop index. Use j for an inner loop index.
```
for (i in 0...10)
{
    for (j in 0...10)
    {
        ...
    }
}
```

Use the singular name of the list name for a for-in loop variable:
```
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
```private function set_label(value:String):String```

Not this:
```private function set_label(lab:String):String```

Or this:
```private function set_label(labelValue:String):String```

Or this:
```private function set_label(val:String):String```

Use event (not e, evt, or eventObj) for the argument of every event handler:

```private function mouseDownHandler(event:Event):Void```

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
```0xFEDCBA```

Not this:
```0xfedcba```  

Always write an RGB color as a six-digit hexadecimal number.

Do this:
```private static inline var BLACK:Int = 0x000000;```

Not this:
```private static inline var BLACK:Int = 0;```

When dealing with indices, use the value -1 to mean “no index”.

### 2.4.3 Float literals

If a number value typically can be fractional, indicate this by using a decimal point, and follow the decimal point by a single trailing zero.

Do this:
```
alphaFrom = 0.0;
alphaTo = 1.0;
```

Not this:
```
alphaFrom = 0;
alphaTo = 1;
```

### 2.4.4 String literals

Use apostrophes (single quotes), not quotation marks (double quotes), to delimit strings.

Do this:
```'What\'s up, "Big Boy"?'```

Not this:
```"What's up, \"Big Boy\"?"```

Use \u, not \U, for unicode escape sequences.

### 2.4.5 Array literals

Use new Array()<T> rather than Array literals.

Do this:
```new Array()<String>()```

Not this:
```[]```

### 2.4.7 Function literals

Avoid using function literals to define anonymous functions; use a class method or package function instead.

If you must use a function literal, declare a return type.

### 2.4.8 RegExp literals

Use the literal notation rather than constructing a EReg instance from a String.

Do this:
```var pattern = ~/haxe/i;```

Not this:
```var pattern = new EReg("haxe", "i");```

### 2.4.10 Class literals

Use a fully-qualified class literal only if necessary to disambiguate between two imported classes with the same unqualified name.

Do this:
```
import mx.controls.Button;
...
var b:Button = new Button();
```

Not this:
```
import mx.controls.Button;
...
var b:Button = new mx.controls.Button();
```

If a type or static field is used a lot in an importing module it might help to alias it to a shorter name. This can also be used to disambiguate conflicting names by giving them a unique identifier.

```
import mx.controls.Button;
import my.controls.Button as MyButton;
...
var b:MyButton = new MyButton();
```
