package lovefox.util
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;

    public class Text2Bitmap extends Object
    {
        public static var SHADOW:DropShadowFilter = new DropShadowFilter(1, 45, 3342336, 0.3, 1, 1, 10, 1, false, false);
        public static var SMASH:GlowFilter = new GlowFilter(0);
        private static var _txt:TextField;
        private static var _tf:TextFormat;

        public function Text2Bitmap()
        {
            return;
        }// end function

        public static function init()
        {
            _txt = Config.getSimpleTextField();
            _tf = new TextFormat();
            return;
        }// end function

        public static function getMinWidth(param1)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = null;
            var _loc_3:* = 0;
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_4 = toBmp(param1[_loc_2]);
                _loc_3 = Math.max(_loc_3, _loc_4.width);
                _loc_4.dispose();
                _loc_2 = _loc_2 + 1;
            }
            return _loc_3;
        }// end function

        public static function toBmp(param1:String, param2 = 16777215, param3 = 12, param4 = null, param5 = false, param6 = false, param7 = false)
        {
            var _loc_9:* = undefined;
            var _loc_10:* = null;
            if (param1 == null)
            {
                return new BitmapData(1, 1, true, 0);
            }
            if (_tf == null)
            {
                init();
            }
            _tf.color = param2;
            _tf.size = param3;
            _tf.bold = param5;
            _tf.italic = param6;
            if (Config._switchEnglish)
            {
                _tf.font = "Tahoma";
            }
            _txt.defaultTextFormat = _tf;
            _txt.text = param1;
            if (param4 == null)
            {
                _txt.filters = [];
            }
            else
            {
                _txt.filters = [param4];
            }
            var _loc_8:* = new BitmapData(Math.max(1, _txt.width), Math.max(1, _txt.height), true, 0);
            new BitmapData(Math.max(1, _txt.width), Math.max(1, _txt.height), true, 0).draw(_txt);
            if (param7)
            {
                return _loc_8;
            }
            _loc_9 = _loc_8.getColorBoundsRect(4278190080, 0, false);
            _loc_10 = new BitmapData(_loc_9.width, _loc_9.height, true, 0);
            _loc_10.copyPixels(_loc_8, _loc_9, new Point());
            _loc_8.dispose();
            return _loc_10;
        }// end function

        public static function toBmpFullName(param1:String, param2 = 16777215, param3 = 12, param4 = null, param5 = false, param6 = false, param7 = false)
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (param1 == null)
            {
                return new BitmapData(1, 1, true, 0);
            }
            if (_tf == null)
            {
                init();
            }
            _tf.color = param2;
            _tf.size = param3;
            _tf.bold = param5;
            _tf.italic = param6;
            if (Config._switchEnglish)
            {
                _tf.font = "Tahoma";
            }
            _txt.defaultTextFormat = _tf;
            _txt.text = param1;
            if (param4 == null)
            {
                _txt.filters = [];
            }
            else
            {
                _txt.filters = [param4];
            }
            var _loc_8:* = new BitmapData(Math.max(1, _txt.width), Math.max(1, _txt.height), true, 0);
            new BitmapData(Math.max(1, _txt.width), Math.max(1, _txt.height), true, 0).draw(_txt);
            if (param7)
            {
                return _loc_8;
            }
            _loc_9 = _loc_8.getColorBoundsRect(4278190080, 0, false);
            _loc_9.x = 0;
            _loc_9.width = _loc_8.width;
            _loc_10 = new BitmapData(_loc_9.width, _loc_9.height, true, 0);
            _loc_10.copyPixels(_loc_8, _loc_9, new Point());
            _loc_8.dispose();
            return _loc_10;
        }// end function

    }
}
