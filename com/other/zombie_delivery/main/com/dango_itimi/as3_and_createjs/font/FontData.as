package com.dango_itimi.as3_and_createjs.font
{
    import flash.*;
    import flash.display.*;

    public class FontData extends Object
    {
        public var width:int;
        public var bitmap:Bitmap;

        public function FontData(param1:Bitmap = undefined, param2:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            bitmap = param1;
            width = param2;
            return;
        }// end function

    }
}
