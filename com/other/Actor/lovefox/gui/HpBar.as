package lovefox.gui
{

    public class HpBar extends Bar
    {

        public function HpBar()
        {
            return;
        }// end function

        override public function redraw(param1 = true)
        {
            var _loc_2:* = undefined;
            if (param1)
            {
                _border.graphics.clear();
                _border.graphics.lineStyle(0, 16777215, 0.5, true);
                _border.graphics.drawRoundRect(0, 0, _width, _height, 3, 3);
            }
            if (_percent > 0.5)
            {
                _loc_2 = 256 * 256 * Math.floor((1 - _percent) * 2 * 255) + 256 * 255;
            }
            else
            {
                _loc_2 = 256 * 256 * 255 + 256 * Math.floor(_percent * 2 * 255);
            }
            _fBar.graphics.clear();
            _fBar.graphics.lineStyle(0, 0, 0, true);
            _fBar.graphics.beginFill(_loc_2);
            _fBar.graphics.drawRoundRect(0, 0, Math.max(1, _width * _percent), _height, 2, 2);
            _fBar.graphics.endFill();
            return;
        }// end function

        public static function create(param1, param2, param3, param4, param5, param6 = null)
        {
            var _loc_7:* = new HpBar;
            new HpBar._width = param1;
            _loc_7._height = param2;
            _loc_7._color = param5;
            _loc_7.x = param3;
            _loc_7.y = param4;
            _loc_7.redraw();
            if (param6 != null)
            {
                param6.addChild(_loc_7);
            }
            return _loc_7;
        }// end function

    }
}
