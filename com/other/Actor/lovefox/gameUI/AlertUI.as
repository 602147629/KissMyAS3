package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import lovefox.component.*;

    public class AlertUI extends Window
    {
        public var _btnArray:Array;
        private var _msgLB:TextAreaUI;
        private var _msgIT:InputText;
        private var _obj:Object;
        private var contain:Sprite;
        public var _disturbCB:CheckBox;
        private static var _ready:Object = true;
        private static var _stack:Array = [];
        private static var _forceStack:Array = [];
        public static var _ui:AlertUI;
        private static var _screenWidth:Object;
        private static var _screenHeight:Object;
        private static var _preForce:Boolean = false;
        private static var _count:uint = 0;
        private static var _alertMap:Object = {};
        public static var _locked:Boolean;

        public function AlertUI(param1)
        {
            this._btnArray = [];
            super(param1);
            closable = false;
            this.resize(220, 135);
            _ui = this;
            if (this.contain != null)
            {
                if (this.contain.parent != null)
                {
                    this.contain.parent.removeChild(this.contain);
                }
            }
            this.contain = new Sprite();
            this.addChild(this.contain);
            this.initDraw();
            if (_stack[0] != null)
            {
                _ui.setAlert(_stack[0]);
            }
            this._disturbCB = new CheckBox(this, 100, 100, Config.language("AlertUI", 1), this.handleDisturb);
            this._disturbCB.tip = Config.language("AlertUI", 2);
            return;
        }// end function

        public function set container(param1)
        {
            _container = param1;
            if (parent != null)
            {
                _container.addChild(this);
            }
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            if (!_opening)
            {
                this.active = true;
                _opening = true;
                testGuide();
            }
            _container.addChild(this);
            return;
        }// end function

        private function handleDisturb(param1)
        {
            Config.disturbMode = this._disturbCB.selected;
            return;
        }// end function

        private function initDraw()
        {
            this._msgLB = new TextAreaUI(this, 15, 20, 190);
            this._msgLB.textColor = Style.WINDOW_FONT;
            this._msgLB.autoHeight = true;
            this._msgIT = new InputText(null, 20, 30);
            this._msgIT.maxChars = 20;
            this._msgIT.width = 180;
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < this._btnArray.length)
            {
                
                removeChild(this._btnArray[_loc_1]);
                if (this._obj.funcs != null && this._obj.funcs[_loc_1] != null)
                {
                    this._btnArray[_loc_1].removeEventListener(MouseEvent.CLICK, this.handleClickBtn);
                }
                _loc_1 = _loc_1 + 1;
            }
            this._btnArray = [];
            this.removeallchild(this.contain);
            return;
        }// end function

        private function subGetFocus(param1 = null)
        {
            Config.stopLoop(this.subGetFocus);
            Config.stage.focus = this._msgIT._tf;
            return;
        }// end function

        public function setAlert(param1)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = undefined;
            if (this._obj != null && this._obj.onReplace != null)
            {
                this._obj.onReplace();
            }
            this._obj = param1;
            if (this._obj != null && this._obj.onReon != null)
            {
                this._obj.onReon();
            }
            data = param1.data;
            this.open();
            this.destroy();
            title = param1.title;
            var _loc_3:* = 30;
            this._msgLB.text = param1.msg;
            _loc_3 = _loc_3 + this._msgLB.height;
            if (param1.hasInput)
            {
                this._msgIT.text = "";
                addChild(this._msgIT);
                this._msgIT.y = _loc_3;
                _loc_3 = _loc_3 + this._msgIT.height;
                Config.startLoop(this.subGetFocus);
            }
            else if (this._msgIT.parent != null)
            {
                this._msgIT.parent.removeChild(this._msgIT);
            }
            if (param1.child != null)
            {
                this.contain.addChild(param1.child);
                param1.child.x = 10;
                param1.child.y = _loc_3;
                if (param1.childHeight == null)
                {
                    _loc_3 = _loc_3 + param1.child.height;
                }
                else
                {
                    _loc_3 = _loc_3 + param1.childHeight;
                }
            }
            _loc_3 = _loc_3 + 20;
            if (this._obj.forceW != null)
            {
                _width = this._obj.forceW;
            }
            else
            {
                _width = 220;
            }
            if (param1.btns != null)
            {
                _loc_4 = (_width + 5 - 10 * (param1.btns.length + 1)) / param1.btns.length;
                if (param1.btns.length == 1)
                {
                    _loc_4 = 80;
                }
                _loc_2 = 0;
                while (_loc_2 < param1.btns.length)
                {
                    
                    this._btnArray[_loc_2] = new PushButton(this, int((this.width - (_loc_4 + 5) * param1.btns.length) / 2 + _loc_2 * (_loc_4 + 5)), _loc_3, param1.btns[_loc_2], this.handleClickBtn);
                    this._btnArray[_loc_2].width = int(_loc_4);
                    this._btnArray[_loc_2].draw();
                    _loc_2 = _loc_2 + 1;
                }
                _loc_3 = _loc_3 + 35;
            }
            if (this._obj.disturb)
            {
                if (this._disturbCB.parent == null)
                {
                    addChild(this._disturbCB);
                }
                this._disturbCB.y = _loc_3;
                _loc_3 = _loc_3 + 20;
            }
            else if (this._disturbCB.parent != null)
            {
                this._disturbCB.parent.removeChild(this._disturbCB);
            }
            if (this._obj.forceW != null && this._obj.forceH != null)
            {
                this.resize(this._obj.forceW, this._obj.forceH);
            }
            else
            {
                this.resize(this._width, _loc_3);
            }
            resize(_screenWidth, _screenHeight);
            return;
        }// end function

        private function handleClickBtn(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            for (_loc_2 in this._btnArray)
            {
                
                if (param1.target.parent == this._btnArray[_loc_2])
                {
                    _loc_3 = this._obj;
                    _loc_4 = this._msgIT.text;
                    if (_loc_3.autoClose)
                    {
                        if (title == Config.language("AwardPanel", 3))
                        {
                            GuideUI.testDoId(224);
                        }
                        close();
                    }
                    if (_loc_3.funcs != null && _loc_3.funcs[_loc_2] != null)
                    {
                        if (_loc_3.hasInput)
                        {
                            var _loc_7:* = _loc_3.funcs;
                            _loc_7._loc_3.funcs[_loc_2](_loc_3.data, _loc_4);
                        }
                        else
                        {
                            var _loc_7:* = _loc_3.funcs;
                            _loc_7._loc_3.funcs[_loc_2](_loc_3.data);
                        }
                    }
                    break;
                }
            }
            return;
        }// end function

        override public function close()
        {
            if (_opening)
            {
                this.active = false;
                _container.removeChild(this);
                _opening = false;
            }
            this._msgLB.text = "";
            this.destroy();
            dispatchEvent(new Event("close"));
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        override public function set active(param1)
        {
            if (param1)
            {
                if (Window._activeWindow != this && Window._activeWindow != null)
                {
                    Window._activeWindow.active = false;
                }
                Window._activeWindow = this;
                _container.addChild(this);
            }
            else if (Window._activeWindow == this)
            {
                Window._activeWindow = null;
            }
            return;
        }// end function

        public static function alert(param1:String, param2:String, param3:Array = null, param4:Array = null, param5 = null, param6:Boolean = false, param7 = true, param8 = false, param9:Sprite = null, param10 = false, param11 = null, param12 = null, param13 = null, param14 = null, param15 = null)
        {
            if (_locked)
            {
                return;
            }
            param2 = param2.replace(/\\\
n""\\n/g, "\n");
            var _loc_16:* = {title:param1, msg:param2, btns:param3, funcs:param4, data:param5, hasInput:param6, autoClose:param7, child:param9, disturb:param10, onReon:param11, onReplace:param12, childHeight:param13, forceW:param14, forceH:param15};
            if (param8)
            {
                _forceStack.unshift(_loc_16);
            }
            else
            {
                _stack.unshift(_loc_16);
            }
            if (_ui != null)
            {
                if (_forceStack.length > 0)
                {
                    _ui.setAlert(_forceStack[0]);
                }
                else
                {
                    _ui.setAlert(_stack[0]);
                }
            }
            _alertMap[_count] = _loc_16;
            var _loc_18:* = _count + 1;
            _count = _loc_18;
            return (_count - 1);
        }// end function

        public static function remove(param1)
        {
            var _loc_3:* = undefined;
            if (param1 < 0)
            {
                return;
            }
            var _loc_2:* = _alertMap[param1];
            _loc_3 = 0;
            while (_loc_3 < _stack.length)
            {
                
                if (_loc_2 == _stack[_loc_3])
                {
                    if (_loc_3 == 0 && _forceStack.length == 0)
                    {
                        close();
                    }
                    else
                    {
                        _stack.splice(_loc_3, 1);
                    }
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public static function close()
        {
            if (_forceStack.length > 0)
            {
                _forceStack.shift();
            }
            else if (_stack.length > 0)
            {
                _stack.shift();
            }
            if (_forceStack.length > 0)
            {
                _ui.setAlert(_forceStack[0]);
            }
            else if (_stack.length > 0)
            {
                _ui.setAlert(_stack[0]);
            }
            else
            {
                _ui.close();
            }
            return;
        }// end function

        public static function set msg(param1)
        {
            param1 = param1.replace(/\\\
n""\\n/g, "\n");
            _ui._msgLB.text = param1;
            return;
        }// end function

        public static function resize(param1, param2)
        {
            _screenWidth = param1;
            _screenHeight = param2;
            if (_ui != null)
            {
                _ui.x = _screenWidth / 2 - _ui.width / 2;
                _ui.y = _screenHeight / 2 - _ui.height / 2 - 20;
            }
            return;
        }// end function

        public static function set msgText(param1:String) : void
        {
            param1 = param1.replace(/\\\
n""\\n/g, "\n");
            _ui._msgLB.text = param1;
            return;
        }// end function

    }
}
