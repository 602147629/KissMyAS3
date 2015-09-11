package zpp_nape.geom
{

    public class ZPP_VecMath extends Object
    {

        public function ZPP_VecMath() : void
        {
            return;
        }// end function

        public static function vec_dsq(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_5 = param1 - param3;
            _loc_6 = param2 - param4;
            return _loc_5 * _loc_5 + _loc_6 * _loc_6;
        }// end function

        public static function vec_distance(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_8:* = 0;
            var _loc_9:* = NaN;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_5 = param1 - param3;
            _loc_6 = param2 - param4;
            var _loc_7:* = _loc_5 * _loc_5 + _loc_6 * _loc_6;
            if (_loc_7 == 0)
            {
                return 0;
            }
            else
            {
                _loc_8 = 1597463007 - (0 >> 1);
                _loc_9 = 0;
                return 0 / (_loc_9 * (1.5 - 0.5 * _loc_7 * _loc_9 * _loc_9));
            }
        }// end function

    }
}
