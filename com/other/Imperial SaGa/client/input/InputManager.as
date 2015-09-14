package input
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;

    public class InputManager extends Object
    {
        private var _inputGroupDisableFlags:uint = 0;
        private var _screen:DisplayObjectContainer;
        private var _aMouseCallback:Array;
        private var _aUseMouseCallback:Array;
        private var _bPickup:Boolean;
        private var _aInputDrag:Array;
        private var _aInputDragStack:Array;
        private var _pickupDrag:InputDrag;
        private var _cursorMc:MovieClip;
        private var _cursor:Point;
        private var _pickupPos:Point;
        private var _bCoursor:Boolean;
        private var _bActive:Boolean = false;
        private var _bNextClick:Boolean = false;
        private var _bEnableCursor:Boolean = false;
        private var _bScreenOut:Boolean = false;
        public static const INPUT_GROUP_DEFAULT:uint = 1;
        public static const INPUT_GROUP_COMMON_POP:uint = 2;
        public static const INPUT_GROUP_CONFIG:uint = 4;
        private static var _instance:InputManager = null;

        public function InputManager(param1:Blocker)
        {
            return;
        }// end function

        public function setDisable(param1:Boolean, param2:uint = 1) : void
        {
            if (param1)
            {
                this._inputGroupDisableFlags = this._inputGroupDisableFlags | param2;
            }
            else
            {
                this._inputGroupDisableFlags = this._inputGroupDisableFlags & ~param2;
            }
            return;
        }// end function

        private function checkDisable(param1:uint) : Boolean
        {
            return (this._inputGroupDisableFlags & param1) != 0;
        }// end function

        public function initialize(param1:DisplayObjectContainer) : void
        {
            this._screen = param1;
            this._aInputDrag = [];
            this._aInputDragStack = new Array();
            this._aMouseCallback = new Array();
            this._aUseMouseCallback = new Array();
            this._cursor = new Point(0, 0);
            this._bCoursor = true;
            this._bPickup = true;
            this._screen.addEventListener(MouseEvent.MOUSE_MOVE, this._mouseMove);
            this._screen.addEventListener(MouseEvent.CLICK, this._mouseClick);
            this._screen.addEventListener(MouseEvent.MOUSE_UP, this._mouseUp);
            this._screen.addEventListener(MouseEvent.MOUSE_DOWN, this._mouseDown);
            this._screen.addEventListener(MouseEvent.MOUSE_WHEEL, this._mouseWheel);
            this._screen.addEventListener(MouseEvent.ROLL_OUT, this._offScreenMouse);
            this._screen.addEventListener(MouseEvent.ROLL_OVER, this._onScreenMouse);
            this._screen.addEventListener(Event.DEACTIVATE, this._cbDeactivate);
            this._screen.addEventListener(Event.ACTIVATE, this._cbActivate);
            return;
        }// end function

        public function removeEvent() : void
        {
            this._screen.removeEventListener(MouseEvent.MOUSE_MOVE, this._mouseMove);
            this._screen.removeEventListener(MouseEvent.CLICK, this._mouseClick);
            this._screen.removeEventListener(MouseEvent.MOUSE_UP, this._mouseUp);
            this._screen.removeEventListener(MouseEvent.MOUSE_DOWN, this._mouseDown);
            this._screen.removeEventListener(MouseEvent.MOUSE_WHEEL, this._mouseWheel);
            this._screen.removeEventListener(MouseEvent.ROLL_OUT, this._offScreenMouse);
            this._screen.removeEventListener(MouseEvent.ROLL_OVER, this._onScreenMouse);
            this._screen.removeEventListener(Event.DEACTIVATE, this._cbDeactivate);
            this._screen.removeEventListener(Event.ACTIVATE, this._cbActivate);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._pickupDrag)
            {
                if (this._bScreenOut || this.checkDisable(this._pickupDrag.inputGroup))
                {
                    Mouse.cursor = MouseCursor.AUTO;
                    this._pickupDrag.OnDrop(null);
                    this._pickupDrag = null;
                }
            }
            return;
        }// end function

        public function addMouseCallback(param1:Object, param2:Function = null, param3:Function = null, param4:Function = null, param5:Function = null, param6:int = 0) : void
        {
            this._addMouseCallback(new MouseCallback(param1, param6, param2, param4, param5, param3, null), this._aMouseCallback);
            this._typeCallbackUpdate();
            return;
        }// end function

        public function addMouseCallbackEx(param1:Object, param2:Function = null, param3:Function = null, param4:Function = null, param5:Function = null, param6:Function = null, param7:int = 0) : void
        {
            this._addMouseCallback(new MouseCallback(param1, param7, param2, param4, param5, param3, param6), this._aMouseCallback);
            this._typeCallbackUpdate();
            return;
        }// end function

        public function enableMouseCallback(param1:Object, param2:Boolean) : void
        {
            var _loc_3:* = this._getMouseCallback(param1, this._aMouseCallback) as MouseCallback;
            if (_loc_3 != null)
            {
                _loc_3.enable(param2);
            }
            return;
        }// end function

        public function delMouseCallback(param1:Object) : void
        {
            this._aMouseCallback = this._delMouseCallback(param1, this._aMouseCallback);
            this._typeCallbackUpdate();
            return;
        }// end function

        public function setInputGroupMouseCallback(param1:Object, param2:uint) : void
        {
            var _loc_3:* = this._getMouseCallback(param1, this._aMouseCallback) as MouseCallback;
            if (_loc_3 != null)
            {
                _loc_3.setInputGroup(param2);
            }
            return;
        }// end function

        public function addDrag(param1:InputDrag) : void
        {
            var _loc_2:* = this._aInputDrag.indexOf(param1);
            if (_loc_2 >= 0)
            {
                return;
            }
            var _loc_3:* = this._aInputDrag.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (param1.priority > this._aInputDrag[_loc_4].priority)
                {
                    this._aInputDrag.splice(_loc_4, 0, param1);
                    break;
                }
                _loc_4++;
            }
            if (_loc_4 >= _loc_3)
            {
                this._aInputDrag.push(param1);
            }
            return;
        }// end function

        public function delDrag(param1:InputDrag) : void
        {
            var _loc_2:* = this._aInputDrag.indexOf(param1);
            if (_loc_2 >= 0)
            {
                this._aInputDrag.splice(_loc_2, 1);
                if (this._pickupDrag == param1)
                {
                    Mouse.cursor = MouseCursor.AUTO;
                    this._pickupDrag = null;
                }
            }
            return;
        }// end function

        public function clearDragAll() : void
        {
            this._aInputDrag = [];
            this._pickupDrag = null;
            this._bPickup = true;
            return;
        }// end function

        public function push() : void
        {
            this._aInputDragStack.push(this._aInputDrag);
            this._aInputDrag = new Array();
            return;
        }// end function

        public function pop() : void
        {
            if (this._aInputDragStack.length > 0)
            {
                this._aInputDrag = this._aInputDragStack.pop();
            }
            else
            {
                this._aInputDrag = new Array();
            }
            return;
        }// end function

        public function set bPickup(param1:Boolean) : void
        {
            this._bPickup = param1;
            return;
        }// end function

        public function get corsor() : Point
        {
            return this._cursor.clone();
        }// end function

        public function get bScreenOut() : Boolean
        {
            return this._bScreenOut;
        }// end function

        private function _cursorEnable(param1:Boolean) : void
        {
            return;
        }// end function

        private function _addMouseCallback(param1:InputBase, param2:Array) : void
        {
            var _loc_3:* = param2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (param1.priority > param2[_loc_4].priority)
                {
                    param2.splice(_loc_4, 0, param1);
                    break;
                }
                _loc_4++;
            }
            if (_loc_4 >= _loc_3)
            {
                param2.push(param1);
            }
            return;
        }// end function

        private function _getMouseCallback(param1:Object, param2:Array) : InputBase
        {
            var _loc_3:* = null;
            for each (_loc_3 in param2)
            {
                
                if (_loc_3.object == param1)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        private function _delMouseCallback(param1:Object, param2:Array) : Array
        {
            var _loc_4:* = null;
            var _loc_3:* = new Array();
            for each (_loc_4 in param2)
            {
                
                if (_loc_4.object != param1)
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        private function _typeCallbackUpdate() : void
        {
            var _loc_1:* = null;
            this._aUseMouseCallback = [];
            for each (_loc_1 in this._aMouseCallback)
            {
                
                this._aUseMouseCallback.push(_loc_1);
            }
            this._aUseMouseCallback.sortOn(["priority"], [Array.NUMERIC | Array.DESCENDING]);
            return;
        }// end function

        private function _mouseMove(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            this._cursor.x = event.stageX;
            this._cursor.y = event.stageY;
            if (this._bCoursor && this._cursorMc)
            {
                this._cursorMc.x = event.stageX;
                this._cursorMc.y = event.stageY;
            }
            if (this._pickupDrag != null && !this.checkDisable(this._pickupDrag.inputGroup))
            {
                this._pickupDrag.OnMove(event);
            }
            for each (_loc_2 in this._aUseMouseCallback)
            {
                
                if (this.checkDisable(_loc_2.inputGroup))
                {
                    continue;
                }
                if (_loc_2.mouseMove(event))
                {
                    break;
                }
            }
            return;
        }// end function

        private function _mouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this._bNextClick)
            {
                this._bNextClick = false;
                return;
            }
            for each (_loc_2 in this._aUseMouseCallback)
            {
                
                if (this.checkDisable(_loc_2.inputGroup))
                {
                    continue;
                }
                if (_loc_2.leftButtonClick(event))
                {
                    break;
                }
            }
            return;
        }// end function

        private function _mouseUp(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aUseMouseCallback)
            {
                
                if (this.checkDisable(_loc_2.inputGroup))
                {
                    continue;
                }
                if (_loc_2.leftButtonUp(event))
                {
                    break;
                }
            }
            if (this._pickupDrag != null && !this.checkDisable(this._pickupDrag.inputGroup))
            {
                Mouse.cursor = MouseCursor.AUTO;
                this._pickupDrag.OnDrop(event);
                this._pickupDrag = null;
            }
            return;
        }// end function

        private function _mouseDown(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._pickupDrag == null)
            {
                _loc_3 = new Point(event.stageX, event.stageY);
                for each (_loc_4 in this._aInputDrag)
                {
                    
                    if (this.checkDisable(_loc_4.inputGroup))
                    {
                        continue;
                    }
                    if (_loc_4.OnDrag(event, _loc_3))
                    {
                        Mouse.cursor = MouseCursor.HAND;
                        this._pickupDrag = _loc_4;
                        break;
                    }
                }
                _loc_3 = null;
            }
            for each (_loc_2 in this._aUseMouseCallback)
            {
                
                if (this.checkDisable(_loc_2.inputGroup))
                {
                    continue;
                }
                if (_loc_2.leftButtonDown(event))
                {
                    this._bNextClick = true;
                    break;
                }
            }
            return;
        }// end function

        private function _mouseWheel(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aUseMouseCallback)
            {
                
                if (this.checkDisable(_loc_2.inputGroup))
                {
                    continue;
                }
                if (_loc_2.mouseWheel(event))
                {
                    break;
                }
            }
            return;
        }// end function

        private function _offScreenMouse(event:MouseEvent) : void
        {
            this._bScreenOut = true;
            this._cursorEnable(false);
            return;
        }// end function

        private function _onScreenMouse(event:MouseEvent) : void
        {
            this._bScreenOut = false;
            this._cursorEnable(true);
            return;
        }// end function

        private function _cbDeactivate(event:Event) : void
        {
            this._bActive = false;
            return;
        }// end function

        private function _cbActivate(event:Event) : void
        {
            this._bActive = true;
            this._bEnableCursor = true;
            return;
        }// end function

        public function isHitTest(param1:Sprite, param2:uint = 1) : Boolean
        {
            return !this.checkDisable(param2) && param1.hitTestPoint(this._cursor.x, this._cursor.y);
        }// end function

        public static function getInstance() : InputManager
        {
            if (!_instance)
            {
                _instance = new InputManager(new Blocker());
            }
            return _instance;
        }// end function

    }
}

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.ui.*;

class Blocker extends Object
{

    function Blocker()
    {
        return;
    }// end function

}

