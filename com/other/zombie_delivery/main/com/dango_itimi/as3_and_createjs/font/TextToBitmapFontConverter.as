package com.dango_itimi.as3_and_createjs.font
{
    import com.dango_itimi.font.*;
    import com.dango_itimi.utils.*;
    import flash.*;
    import flash.display.*;
    import flash.geom.*;

    public class TextToBitmapFontConverter extends Object
    {
        public var twoByteFontSpriteSheet:FontSpriteSheet;
        public var oneByteFontSpriteSheet:FontSpriteSheet;
        public var jis0208:JIS0208;
        public var jis0201:JIS0201;
        public static var init__:Boolean;
        public static var JIS_0201_EReg:EReg;

        public function TextToBitmapFontConverter(param1:int = 0, param2:Class = undefined, param3:Class = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            twoByteFontSpriteSheet = Type.createInstance(param2, [param1]);
            if (param3 != null)
            {
                oneByteFontSpriteSheet = Type.createInstance(param3, [param1]);
            }
            jis0208 = new JIS0208();
            jis0201 = new JIS0201();
            return;
        }// end function

        public function getCropRectangle(param1:int, param2:FontSpriteSheet) : Rectangle
        {
            var _loc_3:* = param2.getCropPoint(param1);
            return new Rectangle(_loc_3.x, _loc_3.y, param2.fontWidth, param2.fontHeight);
        }// end function

        public function execute(param1:String) : Array
        {
            if (oneByteFontSpriteSheet == null)
            {
                return convertTwoByteOnly(param1);
            }
            else
            {
                return convert(param1);
            }
        }// end function

        public function createTwoByteFont(param1:Rectangle) : Bitmap
        {
            return null;
        }// end function

        public function createOneByteFont(param1:Rectangle) : Bitmap
        {
            return null;
        }// end function

        public function convertTwoByteOnly(param1:String) : Array
        {
            var _loc_5:* = 0;
            var _loc_6:* = null as Rectangle;
            var _loc_7:* = null as Bitmap;
            var _loc_2:* = jis0208.getIndexSet(StringUtil.convertOneByteToTwoByte(param1));
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = _loc_2[_loc_4];
                _loc_4++;
                _loc_6 = getCropRectangle(_loc_5, twoByteFontSpriteSheet);
                _loc_7 = createTwoByteFont(_loc_6);
                _loc_3.push(new FontData(_loc_7, twoByteFontSpriteSheet.fontWidth));
            }
            return _loc_3;
        }// end function

        public function convert(param1:String) : Array
        {
            var _loc_5:* = 0;
            var _loc_6:* = null as String;
            var _loc_7:* = 0;
            var _loc_8:* = null as JISFont;
            var _loc_9:* = null as FontSpriteSheet;
            var _loc_10:* = null as Function;
            var _loc_11:* = 0;
            var _loc_12:* = null as Rectangle;
            var _loc_13:* = null as Bitmap;
            var _loc_2:* = [];
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_4++;
                _loc_5 = _loc_4;
                _loc_6 = param1.charAt(_loc_5);
                if (TextToBitmapFontConverter.JIS_0201_EReg.match(_loc_6))
                {
                    _loc_7 = oneByteFontSpriteSheet.fontWidth;
                    _loc_8 = jis0201;
                    _loc_9 = oneByteFontSpriteSheet;
                    _loc_10 = createOneByteFont;
                }
                else
                {
                    _loc_7 = twoByteFontSpriteSheet.fontWidth;
                    _loc_8 = jis0208;
                    _loc_9 = twoByteFontSpriteSheet;
                    _loc_10 = createTwoByteFont;
                }
                _loc_11 = _loc_8.getIndex(_loc_6);
                _loc_12 = getCropRectangle(_loc_11, _loc_9);
                _loc_13 = this._loc_10(_loc_12);
                _loc_2.push(new FontData(_loc_13, _loc_7));
            }
            return _loc_2;
        }// end function

    }
}
