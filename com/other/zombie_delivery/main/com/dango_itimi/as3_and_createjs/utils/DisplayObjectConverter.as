package com.dango_itimi.as3_and_createjs.utils
{
    import com.dango_itimi.utils.*;
    import flash.display.*;

    public class DisplayObjectConverter extends Object
    {

        public function DisplayObjectConverter() : void
        {
            return;
        }// end function

        public static function toRectangleUtil(param1:DisplayObject) : RectangleUtil
        {
            var _loc_2:* = RectangleUtil.convert(param1);
            return _loc_2;
        }// end function

    }
}
