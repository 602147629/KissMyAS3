package com.dango_itimi.font
{
    import flash.*;

    public class FontSpriteSheet extends Object
    {
        public var width:int;
        public var fontWidth:int;
        public var fontHeight:int;

        public function FontSpriteSheet(param1:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            width = width * param1;
            fontHeight = fontHeight * param1;
            fontWidth = fontWidth * param1;
            return;
        }// end function

        public function getCropPoint(param1:int) : Object
        {
            var _loc_2:* = param1 * fontWidth;
            var _loc_3:* = _loc_2 % width / fontWidth;
            var _loc_4:* = Math.floor(_loc_2 / width);
            return {x:_loc_3 * fontWidth, y:_loc_4 * fontHeight};
        }// end function

    }
}
