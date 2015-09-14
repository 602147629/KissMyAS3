package utility
{
    import flash.geom.*;

    public class ColorTransformUtil extends Object
    {

        public function ColorTransformUtil()
        {
            return;
        }// end function

        public static function isMatchColorTransform(param1:ColorTransform, param2:ColorTransform) : Boolean
        {
            if (param1.redMultiplier != param2.redMultiplier)
            {
                return false;
            }
            if (param1.greenMultiplier != param2.greenMultiplier)
            {
                return false;
            }
            if (param1.blueMultiplier != param2.blueMultiplier)
            {
                return false;
            }
            if (param1.alphaMultiplier != param2.alphaMultiplier)
            {
                return false;
            }
            if (param1.redOffset != param2.redOffset)
            {
                return false;
            }
            if (param1.greenOffset != param2.greenOffset)
            {
                return false;
            }
            if (param1.blueOffset != param2.blueOffset)
            {
                return false;
            }
            if (param1.alphaOffset != param2.alphaOffset)
            {
                return false;
            }
            return true;
        }// end function

        public static function interpolateTransform(param1:ColorTransform, param2:ColorTransform, param3:Number) : ColorTransform
        {
            var _loc_4:* = calcMultiplier(param1.redMultiplier, param2.redMultiplier, param3);
            var _loc_5:* = calcMultiplier(param1.greenMultiplier, param2.greenMultiplier, param3);
            var _loc_6:* = calcMultiplier(param1.blueMultiplier, param2.blueMultiplier, param3);
            var _loc_7:* = calcMultiplier(param1.alphaMultiplier, param2.alphaMultiplier, param3);
            var _loc_8:* = calcOffset(param1.redOffset, param2.redOffset, param3);
            var _loc_9:* = calcOffset(param1.greenOffset, param2.greenOffset, param3);
            var _loc_10:* = calcOffset(param1.blueOffset, param2.blueOffset, param3);
            var _loc_11:* = calcOffset(param1.alphaOffset, param2.alphaOffset, param3);
            return new ColorTransform(_loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10, _loc_11);
        }// end function

        private static function calcMultiplier(param1:Number, param2:Number, param3:Number) : Number
        {
            var _loc_4:* = param1 + (param2 - param1) * param3;
            if (param1 + (param2 - param1) * param3 < -1)
            {
                _loc_4 = -1;
            }
            else if (_loc_4 > 1)
            {
                _loc_4 = 1;
            }
            return _loc_4;
        }// end function

        private static function calcOffset(param1:Number, param2:Number, param3:Number) : Number
        {
            var _loc_4:* = param1 + (param2 - param1) * param3;
            if (param1 + (param2 - param1) * param3 < -255)
            {
                _loc_4 = -255;
            }
            else if (_loc_4 > 255)
            {
                _loc_4 = 255;
            }
            return _loc_4;
        }// end function

    }
}
