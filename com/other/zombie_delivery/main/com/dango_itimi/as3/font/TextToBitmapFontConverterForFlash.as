package com.dango_itimi.as3.font
{
    import com.dango_itimi.as3_and_createjs.font.*;
    import flash.*;
    import flash.display.*;
    import flash.geom.*;

    public class TextToBitmapFontConverterForFlash extends TextToBitmapFontConverter
    {
        public var twoByteBaseFontBitmapData:BitmapData;
        public var oneByteBaseFontBitmapData:BitmapData;

        public function TextToBitmapFontConverterForFlash(param1:int = 0, param2:Class = undefined, param3:Class = undefined, param4:Class = undefined, param5:Class = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            twoByteBaseFontBitmapData = Type.createInstance(param3, []);
            if (param5 != null)
            {
                oneByteBaseFontBitmapData = Type.createInstance(param5, []);
            }
            super(param1, param2, param4);
            return;
        }// end function

        override public function createTwoByteFont(param1:Rectangle) : Bitmap
        {
            return createFont(param1, twoByteFontSpriteSheet.fontWidth, twoByteFontSpriteSheet.fontHeight, twoByteBaseFontBitmapData);
        }// end function

        override public function createOneByteFont(param1:Rectangle) : Bitmap
        {
            return createFont(param1, oneByteFontSpriteSheet.fontWidth, oneByteFontSpriteSheet.fontHeight, oneByteBaseFontBitmapData);
        }// end function

        public function createFont(param1:Rectangle, param2:int, param3:int, param4:BitmapData) : Bitmap
        {
            var _loc_5:* = new BitmapData(param2, param3);
            _loc_5.copyPixels(param4, param1, new Point());
            var _loc_6:* = new Bitmap(_loc_5);
            return _loc_6;
        }// end function

    }
}
