package utility
{

    public class ArrayUtil extends Object
    {

        public function ArrayUtil()
        {
            return;
        }// end function

        public static function uniquePushId(param1:Array, param2:int) : void
        {
            var _loc_3:* = param1.indexOf(param2);
            if (_loc_3 < 0)
            {
                param1.push(param2);
            }
            return;
        }// end function

        public static function uniquePushIdArray(param1:Array, param2:Array) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            for each (_loc_3 in param2)
            {
                
                _loc_4 = param1.indexOf(_loc_3);
                if (_loc_4 < 0)
                {
                    param1.push(_loc_3);
                }
            }
            return;
        }// end function

    }
}
