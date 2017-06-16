using com.sakura.common.model.HeidiArea;

class TestConvention {
    private var _toto:String; //ok
    private var toto:String;

    public var _tata:String;
    public var tata:String; //ok

    public var TATA:String;
    var TOTO:Int;

    private var _TATA:String;

    private static var TATA_TOTO:String;
    private static inline var TATA_TOTO22:String = "";// ";" should have a whitespace after them
    private static inline var _TATA_TOTO22:String = "";

    public static inline var _TATA_TOTO223:String = "";
    public static inline var TATA_TOTO223:String = ""; //ok

    public function new () {}

    // Emits a warning : complexity is 8 cause there is 8 tests (true && true) as a score of 2
    public function conditionOperatorsTest ():Void {
        // correct
        if (true && true) {}

        // Correct
        if (true
        && true) {}

        // Incorrect
        if (true &&
        true) {}

        // correct (Rudy & Thomas V)
        true ? trace("Hello") : false;
    }
    // The following spaces are here to test the max empty lines nb



    public function localVarTest ():Void {
        var testArray:Array = [];
        testArray.push(1);
        // Incorrect
        testArray[ 0 ];
        // Correct
        testArray[0];
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

                            }
                        }
                    }
                }
            }
        }
    }
}
