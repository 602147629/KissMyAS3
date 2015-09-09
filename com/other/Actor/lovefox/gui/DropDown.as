package lovefox.gui
{
    import com.bit101.components.*;
    import flash.text.*;

    public class DropDown extends Panel
    {
        public static var _dropDown:DropDown;
        public static var _handler:Function;
        private static var _buttonArray:Array = [];
        private static var _infoPanel:Panel;

        public function DropDown()
        {
            this.roundCorner = 7;
            this.borderColor = 8410936;
            this.border = 1;
            this.color = 16709562;
            _dropDown = this;
            return;
        }// end function

        private static function clear()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < _buttonArray.length)
            {
                
                _dropDown.removeChild(_buttonArray[_loc_1]);
                _buttonArray[_loc_1].removeEventListener(MouseEvent.CLICK, handleButtonClick);
                _buttonArray[_loc_1].removeEventListener(MouseEvent.ROLL_OVER, handleButtonRollOver);
                _buttonArray[_loc_1].removeEventListener(MouseEvent.ROLL_OUT, handleButtonRollOut);
                _buttonArray[_loc_1] = null;
                _loc_1 = _loc_1 + 1;
            }
            _buttonArray = [];
            if (_infoPanel != null)
            {
                if (_infoPanel.parent != null)
                {
                    _infoPanel.parent.removeChild(_infoPanel);
                }
                _infoPanel = null;
            }
            if (_dropDown.parent == Config.ui)
            {
                Config.ui.removeChild(_dropDown);
            }
            return;
        }// end function

        public static function close()
        {
            clear();
            Config.stage.removeEventListener(MouseEvent.MOUSE_DOWN, handleStageMouseDown);
            return;
        }// end function

        private static function handleStageMouseDown(param1)
        {
            if (!_dropDown.hitTestPoint(Config.stage.mouseX, Config.stage.mouseY))
            {
                close();
            }
            return;
        }// end function

        private static function handleMouseOut(param1)
        {
            close();
            return;
        }// end function

        private static function handleButtonClick(param1)
        {
            var _loc_2:* = undefined;
            if (_handler != null)
            {
                _loc_2 = param1.currentTarget.data;
                _handler(_loc_2);
                close();
            }
            return;
        }// end function

        private static function handleButtonRollOver(param1)
        {
            param1.currentTarget.color = 8571351;
            return;
        }// end function

        private static function handleButtonRollOut(param1)
        {
            param1.currentTarget.color = 16709562;
            return;
        }// end function

        public static function dropDown(param1, param2 = null, param3 = null)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            if (_dropDown == null)
            {
                new DropDown;
            }
            clear();
            var _loc_6:* = 110;
            var _loc_7:* = 5;
            if (param3 != null)
            {
                _infoPanel = new Panel(_dropDown, 5, _loc_7);
                _loc_5 = Config.getSimpleTextField();
                _loc_5.width = _loc_6 - 10;
                _loc_5.wordWrap = true;
                _loc_5.htmlText = "<p align=\'center\'>" + param3 + "</p>";
                _loc_5.textColor = 10512164;
                _infoPanel.addChild(_loc_5);
                _infoPanel.width = _loc_6 - 10;
                _infoPanel.height = _loc_5.height;
                _infoPanel.color = 16760672;
                _loc_7 = _loc_7 + (_infoPanel.height + 5);
            }
            _loc_4 = 0;
            while (_loc_4 < param1.length)
            {
                
                _buttonArray[_loc_4] = new Panel(_dropDown, 5, _loc_7 + _loc_4 * 20);
                _buttonArray[_loc_4].width = _loc_6 - 10;
                _buttonArray[_loc_4].height = 20;
                _loc_5 = Config.getSimpleTextField();
                _loc_5.text = param1[_loc_4];
                _loc_5.x = (_buttonArray[_loc_4].width - _loc_5.width) / 2;
                _loc_5.y = (_buttonArray[_loc_4].height - _loc_5.height) / 2;
                _loc_5.textColor = 5977896;
                _buttonArray[_loc_4].addChild(_loc_5);
                _buttonArray[_loc_4].data = _loc_4;
                _buttonArray[_loc_4].addEventListener(MouseEvent.CLICK, handleButtonClick);
                _buttonArray[_loc_4].addEventListener(MouseEvent.ROLL_OVER, handleButtonRollOver);
                _buttonArray[_loc_4].addEventListener(MouseEvent.ROLL_OUT, handleButtonRollOut);
                _buttonArray[_loc_4].buttonMode = true;
                _buttonArray[_loc_4].shadow = 0;
                _buttonArray[_loc_4].color = 16709562;
                _loc_4 = _loc_4 + 1;
            }
            _dropDown.width = _loc_6;
            _dropDown.height = param1.length * 20 + 10 + _loc_7 - 5;
            _dropDown.x = Config.ui.mouseX - 2;
            _dropDown.y = Math.min(Config.ui.mouseY - 2, Config.ui._height - _dropDown.height);
            _handler = param2;
            Config.ui.addChild(_dropDown);
            Config.stage.removeEventListener(MouseEvent.MOUSE_DOWN, handleStageMouseDown);
            Config.stage.addEventListener(MouseEvent.MOUSE_DOWN, handleStageMouseDown);
            return;
        }// end function

    }
}
