package utility
{
    import mx.utils.*;

    public class StringTools extends Object
    {

        public function StringTools()
        {
            return;
        }// end function

        public static function format(param1:String, ... args) : String
        {
            return StringUtil.substitute(param1, args);
        }// end function

        public static function xmlLineToStringLine(param1:String) : String
        {
            return param1.replace(/\\\
n""\\n/g, "\n");
        }// end function

        public static function timeTextSec(param1:int) : String
        {
            var _loc_2:* = param1 % 60;
            var _loc_3:* = param1 / 60 % 60;
            var _loc_4:* = param1 / 60 / 60;
            if (param1 / 60 / 60 > 99)
            {
                _loc_4 = 99;
            }
            return (_loc_4 < 10 ? ("0" + _loc_4.toString()) : (_loc_4)) + ":" + (_loc_3 < 10 ? ("0" + _loc_3.toString()) : (_loc_3)) + ":" + (_loc_2 < 10 ? ("0" + _loc_2.toString()) : (_loc_2));
        }// end function

        public static function timeTextSec322(param1:int) : String
        {
            var _loc_2:* = param1 % 60;
            var _loc_3:* = param1 / 60 % 60;
            var _loc_4:* = param1 / 60 / 60;
            if (param1 / 60 / 60 > 999)
            {
                _loc_4 = 999;
            }
            return (_loc_4 < 10 ? ("0" + _loc_4.toString()) : (_loc_4)) + ":" + (_loc_3 < 10 ? ("0" + _loc_3.toString()) : (_loc_3)) + ":" + (_loc_2 < 10 ? ("0" + _loc_2.toString()) : (_loc_2));
        }// end function

    }
}
