using com.sakura.common.model.HeidiArea;

class TestConvention {
    private var _toto:String; //ok
    private var toto:String; //nok

    public var _tata:String; //nok
    public var tata:String; //ok

    public var TATA:String; //nok
    var TOTO:Int; // visibility not specified + uppercase

    private var _TATA:String; // uppercase

    private static var TATA_TOTO:String;
    private static inline var TATA_TOTO22:String = '';// ";" should have a whitespace after them
    private static inline var _TATA_TOTO22:String = '';

    public static inline var _TATA_TOTO223:String = '';
    public static inline var TATA_TOTO223:String = ''; //ok

    // Empty block error
    public function new () {

    }

    // Emits a warning : complexity is 8 cause there is 8 tests (true && true) as a score of 2
    public function conditionOperatorsTest ():String {
        var i = '';

        // correct
        if (true && true) {
            i += 'i';
        }

        // Correct
        if (true
        && true) {
            i += 'i';
        }

        // Incorrect
        if (true &&
        true) {
            // Info about whitespace
            i+= 'i';
        }

        var incorrectDoubleQuotes = "debug";

        // correct (Rudy & Thomas V)
        true ? trace('Hello') : false;

        return i;
    }
    // The following spaces are here to test the max empty lines nb



    public function localVarTest ():Void {
        var array:Array<Int> = new Array<Int>(); // must not throw warning
        array.push(1);

        var testArray:Array = [];
        testArray.push(1);
        // Incorrect
        testArray[ 0 ];
        // Correct
        testArray[0];
    }

    public function ifelsecondition ():Void {
        if (true) {
            // unused var
            var unused = 1;
        }
    }

    // OK
    public function testNormalMethod():Void {}

    // Not a handler, error
    public function testNormal_Method():Void {}

    // correct
    public function testNormalHandler():Void {}

    // correct, method ends with "Handler", underscore is authorized
    public function test_UnderscoreHandler():Void {}

    public function testReturnTypeNotSpecified() {}

    // Bad : more than 5 if nested
    public function badNestedIfTest():Void {
        if (true) {
            if (true) {
                if (true) {
                    if (true) {
                        if (true) {
                            if (true) {
                                return;
                            }
                        }
                    }
                }
            }
        }
    }
}
