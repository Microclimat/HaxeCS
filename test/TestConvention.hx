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
    public static inline var TATA_TOTO223:String = "";
    //ok

    public function new () {

    }

    public function conditionOperatorsTest () {
        // correct
        if (true && true) {
        }

        // Correct
        if (true
        && true) {
        }

        // Incorrect
        if (true &&
        true) {
        }

        // Incorrect
        true ? trace("Hello") : trace("Bad");
    }



    public function localVarTest () {
        var testArray:Array = [];
        testArray.push(1);
        // Incorrect
        testArray[ 0 ];
        // Correct
        testArray[0];
    }
}
