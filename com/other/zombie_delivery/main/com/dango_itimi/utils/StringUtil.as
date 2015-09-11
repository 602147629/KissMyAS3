package com.dango_itimi.utils
{

    public class StringUtil extends Object
    {
        public static var CR:String;
        public static var LF:String;

        public function StringUtil() : void
        {
            return;
        }// end function

        public static function convertOneByteToTwoByte(param1:String) : String
        {
            var _loc_5:* = 0;
            var _loc_2:* = "";
            var _loc_3:* = 0;
            var _loc_4:* = param1.length;
            while (_loc_3 < _loc_4)
            {
                
                _loc_3++;
                _loc_5 = _loc_3;
                _loc_2 = _loc_2 + new EReg("[!-~]", "g").replace(param1.charAt(_loc_5), String.fromCharCode(param1.charCodeAt(_loc_5) + 65248));
            }
            return _loc_2;
        }// end function

        public static function addZeroToHeadOfNumber(param1:int, param2:int) : String
        {
            var _loc_6:* = 0;
            var _loc_3:* = "" + param1;
            var _loc_4:* = param2 - _loc_3.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_5++;
                _loc_6 = _loc_5;
                _loc_3 = "0" + _loc_3;
            }
            return _loc_3;
        }// end function

        public static function splitWithNewline(param1:String) : Array
        {
            param1 = StringUtil.replaceNewline(param1, "\r" + "\n", "\r");
            param1 = StringUtil.replaceNewline(param1, "\n", "\r");
            return param1.split("\r");
        }// end function

        public static function replaceNewline(param1:String, param2:String, param3:String) : String
        {
            var _loc_4:* = param1.split(param2);
            return _loc_4.join(param3);
        }// end function

    }
}
