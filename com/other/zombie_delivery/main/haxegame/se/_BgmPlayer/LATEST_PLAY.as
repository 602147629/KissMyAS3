package haxegame.se._BgmPlayer
{
    import flash.*;

    final public class LATEST_PLAY extends Object
    {
        public var tag:String;
        public var index:int;
        public var params:Array;
        public const __enum__:Boolean = true;
        public static const __isenum:Boolean = true;
        public static var __constructs__:Object;
        public static var BGM2:LATEST_PLAY;
        public static var BGM1:LATEST_PLAY;

        public function LATEST_PLAY(param1:String, param2:int, param3) : void
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
