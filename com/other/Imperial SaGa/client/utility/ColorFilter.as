package utility
{
    import flash.filters.*;

    public class ColorFilter extends Object
    {

        public function ColorFilter()
        {
            return;
        }// end function

        public static function getGrayscaleNTSC() : ColorMatrixFilter
        {
            var _loc_1:* = 0.298912;
            var _loc_2:* = 0.586611;
            var _loc_3:* = 0.114478;
            var _loc_4:* = new Array();
            _loc_4 = new Array().concat([_loc_1, _loc_2, _loc_3, 0, 0]);
            _loc_4 = _loc_4.concat([_loc_1, _loc_2, _loc_3, 0, 0]);
            _loc_4 = _loc_4.concat([_loc_1, _loc_2, _loc_3, 0, 0]);
            _loc_4 = _loc_4.concat([0, 0, 0, 1, 0]);
            return new ColorMatrixFilter(_loc_4);
        }// end function

        public static function getGrayscaleAvg(param1:Number, param2:Number) : ColorMatrixFilter
        {
            var _loc_3:* = 0;
            if (param2 > 0)
            {
                _loc_3 = param1 / param2;
            }
            else
            {
                _loc_3 = 1;
            }
            var _loc_4:* = 1 - 0.666667 * _loc_3;
            var _loc_5:* = (1 - _loc_4) * 0.5;
            var _loc_6:* = new Array();
            _loc_6 = new Array().concat([_loc_4, _loc_5, _loc_5, 0, 0]);
            _loc_6 = _loc_6.concat([_loc_5, _loc_4, _loc_5, 0, 0]);
            _loc_6 = _loc_6.concat([_loc_5, _loc_5, _loc_4, 0, 0]);
            _loc_6 = _loc_6.concat([0, 0, 0, 1, 0]);
            return new ColorMatrixFilter(_loc_6);
        }// end function

    }
}
