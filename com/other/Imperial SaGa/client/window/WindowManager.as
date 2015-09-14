package window
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;

    public class WindowManager extends Object
    {
        private var _aWindow:Array;
        private var _waitCloseWindow:WindowBase;
        public static const WINDOW_TYPE_DIALOG:int = 1;
        private static var _instance:WindowManager;

        public function WindowManager()
        {
            return;
        }// end function

        public function init() : void
        {
            this._aWindow = [];
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._aWindow)
            {
                
                _loc_3.control();
                if (_loc_3.bEnd)
                {
                    _loc_3.windowCloseFunc();
                    this.removeWindow(_loc_3);
                    continue;
                }
                _loc_2.push(_loc_3);
            }
            this._aWindow = _loc_2;
            return;
        }// end function

        public function createDialogWindow(param1:Sprite, param2:String, param3:WindowStyle, param4:Point, param5:Boolean = true, param6:Function = null) : void
        {
            var _loc_7:* = new WindowMenu(param6, 0, param3);
            new WindowMenu(param6, 0, param3).open(param4.x, param4.y);
            _loc_7.addWindowItem(new WindowText(param2));
            if (param5)
            {
                _loc_7.addWindowItem(new WindowButton(MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CLOSE), null));
            }
            else
            {
                this._waitCloseWindow = _loc_7 as WindowBase;
                InputManager.getInstance().addMouseCallback(this, null, null, this.cbClickMessage);
            }
            param1.addChild(_loc_7);
            this._aWindow.push(_loc_7);
            return;
        }// end function

        public function createAlertDialogWindow(param1:Sprite, param2:String, param3:WindowStyle, param4:Function = null, param5:String = null) : void
        {
            var spr:* = param1;
            var msg:* = param2;
            var style:* = param3;
            var cbWindowClose:* = param4;
            var btnText:* = param5;
            var windowMenu:* = new WindowMenu(null, 0, style);
            windowMenu.addWindowItem(new WindowText(msg));
            windowMenu.open(Constant.SCREEN_WIDTH_HALF - windowMenu.width / 2, Constant.SCREEN_HEIGHT_HALF - windowMenu.height / 2);
            if (btnText == null)
            {
                btnText = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CONFIRM);
            }
            windowMenu.addWindowItem(new WindowButton(btnText, function () : void
            {
                if (cbWindowClose != null)
                {
                    cbWindowClose();
                }
                return;
            }// end function
            , WindowButton.POS_DEFAULT));
            spr.addChild(windowMenu);
            this._aWindow.push(windowMenu);
            return;
        }// end function

        public function createYesNoDialogWindow(param1:Sprite, param2:String, param3:WindowStyle, param4:Function = null, param5:String = null, param6:String = null, param7:Boolean = false) : void
        {
            var spr:* = param1;
            var msg:* = param2;
            var style:* = param3;
            var cbWindowClose:* = param4;
            var positiveBtnText:* = param5;
            var negativeBtnText:* = param6;
            var btnReverse:* = param7;
            var windowMenu:* = new WindowMenu(null, 0, style);
            windowMenu.addWindowItem(new WindowText(msg));
            windowMenu.open(Constant.SCREEN_WIDTH_HALF - windowMenu.width / 2, Constant.SCREEN_HEIGHT_HALF - windowMenu.height / 2);
            if (positiveBtnText == null)
            {
                positiveBtnText = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_YES);
            }
            if (negativeBtnText == null)
            {
                negativeBtnText = MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_NO);
            }
            windowMenu.addWindowItem(new WindowButton(positiveBtnText, function () : void
            {
                cbWindowClose(true);
                return;
            }// end function
            , !btnReverse ? (WindowButton.POS_LEFT) : (WindowButton.POS_RIGHT)));
            windowMenu.addWindowItem(new WindowButton(negativeBtnText, function () : void
            {
                cbWindowClose(false);
                return;
            }// end function
            , !btnReverse ? (WindowButton.POS_RIGHT) : (WindowButton.POS_LEFT)));
            spr.addChild(windowMenu);
            this._aWindow.push(windowMenu);
            return;
        }// end function

        public function createSkillNameWindow(param1:Sprite, param2:String, param3:WindowStyle, param4:Point) : WindowMenu
        {
            var _loc_5:* = new WindowMenu(null, 0, param3);
            new WindowMenu(null, 0, param3).open(param4.x, param4.y);
            _loc_5.addWindowItem(new WindowText(param2));
            param1.addChild(_loc_5);
            this._aWindow.push(_loc_5);
            return _loc_5;
        }// end function

        public function createSkillMenuWindow(param1:Sprite, param2:Array, param3:WindowStyle, param4:Point, param5:Function = null) : WindowMenu
        {
            var _loc_7:* = null;
            var _loc_6:* = new WindowMenu(param5, 0, param3);
            new WindowMenu(param5, 0, param3).open(param4.x, param4.y);
            for each (_loc_7 in param2)
            {
                
                _loc_6.addWindowItem(_loc_7);
            }
            param1.addChild(_loc_6);
            this._aWindow.push(_loc_6);
            return _loc_6;
        }// end function

        public function createMenuWindow(param1:Sprite, param2:Array, param3:WindowStyle, param4:Point, param5:Function = null) : WindowMenu
        {
            var _loc_7:* = null;
            var _loc_6:* = new WindowMenu(param5, 0, param3);
            new WindowMenu(param5, 0, param3).open(param4.x, param4.y);
            for each (_loc_7 in param2)
            {
                
                _loc_6.addWindowItem(_loc_7);
            }
            param1.addChild(_loc_6);
            this._aWindow.push(_loc_6);
            return _loc_6;
        }// end function

        public function createPageMenuWindow(param1:Sprite, param2:Array, param3:WindowStyle, param4:Point, param5:Function = null, param6:int = 5, param7:int = 1) : WindowPageMenu
        {
            var _loc_9:* = null;
            var _loc_8:* = new WindowPageMenu(param5, 0, param3, param6, param7);
            new WindowPageMenu(param5, 0, param3, param6, param7).open(param4.x, param4.y);
            for each (_loc_9 in param2)
            {
                
                _loc_8.addWindowItem(_loc_9);
            }
            param1.addChild(_loc_8);
            this._aWindow.push(_loc_8);
            return _loc_8;
        }// end function

        public function removeWindow(param1:WindowBase) : void
        {
            var _loc_2:* = 0;
            if (param1 != null)
            {
                _loc_2 = this._aWindow.indexOf(param1);
                if (_loc_2 >= 0)
                {
                    param1.release();
                    this._aWindow.splice(_loc_2, 1);
                }
                param1 = null;
            }
            return;
        }// end function

        private function cbClickMessage(event:MouseEvent) : void
        {
            if (this._waitCloseWindow != null)
            {
                this._waitCloseWindow.close();
                InputManager.getInstance().delMouseCallback(this);
            }
            return;
        }// end function

        public static function getInstance() : WindowManager
        {
            if (_instance == null)
            {
                _instance = new WindowManager;
            }
            return _instance;
        }// end function

    }
}
