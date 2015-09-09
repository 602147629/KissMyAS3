package lovefox.gameUI
{
    import flash.display.*;

    public class Billboard extends Bitmap
    {
        public static var _billboard:Billboard;
        private static var _showCount:Number;
        private static var _showTimer:Number;
        private static var _buffStack:Array = [];
        private static var _lock:Boolean = false;
        private static var _wordLen:uint;

        public function Billboard()
        {
            this.filters = [new GlowFilter(0, 1, 2, 2, 10), new DropShadowFilter(5, 45, 0, 0.5)];
            return;
        }// end function

        public static function resize()
        {
            if (_billboard != null && _billboard.bitmapData != null)
            {
                _billboard.x = (Config.ui._width - _billboard.bitmapData.width) / 2;
                if (Config._switchEnglish)
                {
                    _billboard.y = 0;
                }
                else
                {
                    _billboard.y = Config.ui._height / 4 - 25 - _billboard.bitmapData.height / 2;
                }
            }
            return;
        }// end function

        public static function show(param1, param2 = null) : void
        {
            var _loc_3:* = null;
            if (Config.player == null)
            {
                return;
            }
            if (param1 == "" || param1 == null)
            {
                return;
            }
            if (!_lock)
            {
                _wordLen = param1.length;
                if (param2 == null)
                {
                    param2 = Style.WHITE_FONT;
                }
                if (_billboard == null)
                {
                    _billboard = new Billboard;
                }
                if (_billboard.bitmapData != null)
                {
                    _billboard.bitmapData.dispose();
                    _billboard.bitmapData = null;
                }
                if (param1.length <= 20)
                {
                    _loc_3 = Text2Bitmap.toBmp(param1, param2, 32, null, true);
                }
                else if (param1.length <= 28)
                {
                    _loc_3 = Text2Bitmap.toBmp(param1, param2, 24, null, true);
                }
                else
                {
                    _loc_3 = Text2Bitmap.toBmp(param1, param2, 16, null, true);
                }
                _billboard.x = (Config.ui._width - _loc_3.width) / 2;
                if (Config._switchEnglish)
                {
                    _billboard.y = 0;
                }
                else
                {
                    _billboard.y = Config.ui._height / 4 - 25 - _loc_3.height / 2;
                }
                _billboard.bitmapData = _loc_3;
                Config.stage.addChild(_billboard);
                initFilter();
                _billboard.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
                _billboard.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
                _lock = true;
            }
            else
            {
                _buffStack.push({word:param1, color:param2});
            }
            return;
        }// end function

        private static function initFilter()
        {
            _showCount = 0;
            _billboard.alpha = 0;
            return;
        }// end function

        private static function handleEnterFrame(param1)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = _showCount + 1;
            _showCount = _loc_4;
            if (_showCount < 10)
            {
                _billboard.alpha = _billboard.alpha + 0.1;
            }
            else if (_showCount < _wordLen * 5 + 100)
            {
            }
            else if (_showCount < _wordLen * 5 + 115)
            {
                _billboard.alpha = _billboard.alpha - 0.2;
            }
            else
            {
                _billboard.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
                hide();
                _lock = false;
                if (_buffStack.length > 0)
                {
                    _loc_2 = _buffStack.shift();
                    show(_loc_2.word, _loc_2.color);
                }
            }
            return;
        }// end function

        private static function hide()
        {
            _billboard.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
            if (_billboard.bitmapData != null)
            {
                _billboard.bitmapData.dispose();
                _billboard.bitmapData = null;
            }
            if (_billboard.parent != null)
            {
                _billboard.parent.removeChild(_billboard);
            }
            return;
        }// end function

    }
}
