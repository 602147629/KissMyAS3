package lovefox.gameUI
{
    import flash.display.*;
    import flash.filters.*;

    public class Neon extends Bitmap
    {
        public static var _neon:Neon;
        private static var _glowFilter:GlowFilter;
        private static var _blurFilter:BlurFilter;
        private static var _showCount:Number;
        private static var _showTimer:Number;

        public function Neon()
        {
            return;
        }// end function

        public static function show(param1) : void
        {
            if (_neon == null)
            {
                _neon = new Neon;
                var _loc_3:* = new BlurFilter();
                _blurFilter = new BlurFilter();
                var _loc_3:* = new GlowFilter(16777215, 1, 1, 1, 3, 2);
                _glowFilter = new GlowFilter(16777215, 1, 1, 1, 3, 2);
                _neon.filters = [_loc_3, _loc_3];
            }
            if (_neon.bitmapData != null)
            {
                _neon.bitmapData.dispose();
                _neon.bitmapData = null;
            }
            if (_neon.parent == null)
            {
                Config.stage.addChild(_neon);
            }
            var _loc_2:* = Text2Bitmap.toBmp(param1, 16775065, 64, null);
            if (Config.ui != null)
            {
                _neon.x = (Config.ui._width - _loc_2.width) / 2;
                _neon.y = Config.ui._height - 200;
            }
            else
            {
                _neon.x = (Config.stage.stageWidth - _loc_2.width) / 2;
                _neon.y = Config.stage.stageHeight - 200;
            }
            _neon.bitmapData = _loc_2;
            initFilter();
            _neon.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
            _neon.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
            return;
        }// end function

        private static function initFilter()
        {
            _showCount = 0;
            _neon.alpha = 0;
            _glowFilter.blurX = 2;
            _glowFilter.blurY = 2;
            _blurFilter.blurX = 2;
            _blurFilter.blurY = 2;
            return;
        }// end function

        private static function handleEnterFrame(param1)
        {
            var _loc_3:* = _showCount + 1;
            _showCount = _loc_3;
            if (_showCount < 15)
            {
                _neon.alpha = _neon.alpha + 0.05;
                _glowFilter.blurX = _glowFilter.blurX + 0.5;
                _glowFilter.blurY = _glowFilter.blurY + 0.5;
                _blurFilter.blurX = _blurFilter.blurX + 0.5;
                _blurFilter.blurY = _blurFilter.blurY + 0.5;
                _neon.filters = [_blurFilter, _glowFilter];
            }
            else if (_showCount < 20)
            {
                _neon.alpha = _neon.alpha + 0.05;
                (_glowFilter.blurX - 1);
                (_glowFilter.blurY - 1);
                _blurFilter.blurX = _blurFilter.blurX - 1.5;
                _blurFilter.blurY = _blurFilter.blurY - 1.5;
                _neon.filters = [_blurFilter, _glowFilter];
            }
            else if (_showCount < 40)
            {
            }
            else if (_showCount < 45)
            {
                _neon.alpha = _neon.alpha - 0.05;
                (_glowFilter.blurX + 1);
                (_glowFilter.blurY + 1);
                _blurFilter.blurX = _blurFilter.blurX + 1.5;
                _blurFilter.blurY = _blurFilter.blurY + 1.5;
                _neon.filters = [_blurFilter, _glowFilter];
            }
            else if (_showCount < 60)
            {
                _neon.alpha = _neon.alpha - 0.05;
                _glowFilter.blurX = _glowFilter.blurX - 0.5;
                _glowFilter.blurY = _glowFilter.blurY - 0.5;
                _blurFilter.blurX = _blurFilter.blurX - 0.5;
                _blurFilter.blurY = _blurFilter.blurY - 0.5;
                _neon.filters = [_blurFilter, _glowFilter];
            }
            else
            {
                _neon.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
                hide();
            }
            return;
        }// end function

        private static function hide()
        {
            _neon.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
            if (_neon.bitmapData != null)
            {
                _neon.bitmapData.dispose();
                _neon.bitmapData = null;
            }
            if (_neon.parent != null)
            {
                _neon.parent.removeChild(_neon);
            }
            return;
        }// end function

    }
}
