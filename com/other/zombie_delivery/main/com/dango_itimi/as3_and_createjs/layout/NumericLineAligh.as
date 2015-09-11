package com.dango_itimi.as3_and_createjs.layout
{
    import flash.*;

    final public class NumericLineAligh extends Object
    {
        public var tag:String;
        public var index:int;
        public var params:Array;
        public const __enum__:Boolean = true;
        public static const __isenum:Boolean = true;
        public static var __constructs__:Object;
        public static var RIGHT:NumericLineAligh;
        public static var LEFT:NumericLineAligh;
        public static var CENTER:NumericLineAligh;

        public function NumericLineAligh(param1:String, param2:int, param3) : void
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
