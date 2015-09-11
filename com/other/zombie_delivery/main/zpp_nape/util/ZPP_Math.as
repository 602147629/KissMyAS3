package zpp_nape.util
{

    public class ZPP_Math extends Object
    {

        public function ZPP_Math() : void
        {
            return;
        }// end function

        public static function sqrt(param1:Number) : Number
        {
            var _loc_2:* = 0;
            var _loc_3:* = NaN;
            if (param1 == 0)
            {
                return 0;
            }
            else
            {
                _loc_2 = 1597463007 - (0 >> 1);
                _loc_3 = 0;
                return 0 / (_loc_3 * (1.5 - 0.5 * param1 * _loc_3 * _loc_3));
            }
        }// end function

        public static function invsqrt(param1:Number) : Number
        {
            var _loc_2:* = 1597463007 - (0 >> 1);
            var _loc_3:* = 0;
            return _loc_3 * (1.5 - 0.5 * param1 * _loc_3 * _loc_3);
        }// end function

        public static function sqr(param1:Number) : Number
        {
            return param1 * param1;
        }// end function

        public static function clamp2(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = -param2;
            if (param1 < _loc_3)
            {
                return _loc_3;
            }
            else if (param1 > param2)
            {
                return param2;
            }
            else
            {
                return param1;
            }
        }// end function

        public static function clamp(param1:Number, param2:Number, param3:Number) : Number
        {
            if (param1 < param2)
            {
                return param2;
            }
            else if (param1 > param3)
            {
                return param3;
            }
            else
            {
                return param1;
            }
        }// end function

    }
}
