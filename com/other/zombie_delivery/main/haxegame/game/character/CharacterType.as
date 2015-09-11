package haxegame.game.character
{
    import flash.*;

    final public class CharacterType extends Object
    {
        public var tag:String;
        public var index:int;
        public var params:Array;
        public const __enum__:Boolean = true;
        public static const __isenum:Boolean = true;
        public static var __constructs__:Object;
        public static var ZOMBIE:CharacterType;
        public static var HUMAN:CharacterType;

        public function CharacterType(param1:String, param2:int, param3) : void
        {
            tag = param1;
            index = param2;
            params = param3;
            return;
        }// end function

        final public function toString() : String
        {
            return Boot.enum_to_string(this);
        }// end function

    }
}
