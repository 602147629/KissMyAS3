package lovefox.gameUI
{
    import flash.display.*;

    public class BubbleUI extends Sprite
    {
        private static var _timer:uint;
        private static var _stack:Array = [];
        private static var _preStr:Object;
        private static var _preTime:Object;

        public function BubbleUI()
        {
            return;
        }// end function

        public static function bubble(param1, param2 = 16711680, param3 = 12, param4 = false)
        {
            var _loc_6:* = null;
            if (param1 == "" || param1 == null)
            {
                return;
            }
            var _loc_5:* = getTimer();
            if (Config.map != null && Config.map._state == "ready" && (_preStr != param1 || _preTime == null || _loc_5 - _preTime >= 1000))
            {
                _preStr = param1;
                _preTime = getTimer();
                _loc_6 = new Bitmap(Text2Bitmap.toBmp(param1, param2, param3, Text2Bitmap.SMASH, param4));
                Config.map.addChild(_loc_6);
                _loc_6.x = Config.map.width / 2 - _loc_6.width / 2;
                _loc_6.y = Config.map.height / 2 - 80;
                _loc_6.alpha = 0;
                _stack.push({bmp:_loc_6, count:0, y:0});
                clearTimeout(_timer);
                _timer = setTimeout(playFrame, 30);
            }
            return;
        }// end function

        private static function playFrame()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            clearTimeout(_timer);
            var _loc_3:* = Config.map.height / 2 - 80;
            _loc_1 = 0;
            while (_loc_1 < _stack.length)
            {
                
                if (_stack[_loc_1].count >= 40 || _stack.length - _loc_1 > 3)
                {
                    _stack[_loc_1].bmp.bitmapData.dispose();
                    _stack[_loc_1].bmp.parent.removeChild(_stack[_loc_1].bmp);
                    _stack.splice(_loc_1, 1);
                    _loc_1 = _loc_1 - 1;
                }
                else
                {
                    break;
                }
                _loc_1 = _loc_1 + 1;
            }
            _loc_1 = 0;
            while (_loc_1 < _stack.length)
            {
                
                var _loc_4:* = _stack[_loc_1];
                var _loc_5:* = _stack[_loc_1].count + 1;
                _loc_4.count = _loc_5;
                _loc_2 = _loc_3 - (_stack.length - _loc_1) * 20;
                if (Math.abs(_stack[_loc_1].bmp.y - _loc_2) > 0.2)
                {
                    _stack[_loc_1].bmp.y = _stack[_loc_1].bmp.y + (_loc_2 - _stack[_loc_1].bmp.y) / 5;
                }
                else
                {
                    _stack[_loc_1].bmp.y = _loc_2;
                }
                if (_stack[_loc_1].count <= 5)
                {
                    _stack[_loc_1].bmp.alpha = _stack[_loc_1].count * 0.2;
                }
                else if (_stack[_loc_1].count >= 35)
                {
                    _stack[_loc_1].bmp.alpha = (40 - _stack[_loc_1].count) * 0.2;
                }
                _loc_1 = _loc_1 + 1;
            }
            if (_stack.length == 0)
            {
            }
            else
            {
                clearTimeout(_timer);
                _timer = setTimeout(playFrame, 30);
            }
            return;
        }// end function

        public static function resize(param1, param2)
        {
            var _loc_3:* = undefined;
            _loc_3 = 0;
            while (_loc_3 < _stack)
            {
                
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
