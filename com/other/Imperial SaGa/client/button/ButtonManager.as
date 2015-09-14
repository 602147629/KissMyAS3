package button
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ButtonManager extends Object
    {
        private var _aButton:Array;
        private var _aButtonStack:Array;
        private var _aNoClickCallback:Array;
        private var _aNoClickStack:Array;
        private var _bMouseDown:Boolean = false;
        private var _cursorPos:Point;
        private var _aSealFlag:Array;
        private var _aArea:Array;
        private static var _instance:ButtonManager = null;

        public function ButtonManager()
        {
            this._aButton = new Array();
            this._aButtonStack = new Array();
            this._aNoClickCallback = new Array();
            this._aNoClickStack = new Array();
            this._aArea = new Array();
            this._aSealFlag = [];
            return;
        }// end function

        public function get bMouseDown() : Boolean
        {
            return this._bMouseDown;
        }// end function

        public function get sealCount() : int
        {
            return this._aSealFlag.length;
        }// end function

        public function init(param1:DisplayObjectContainer) : void
        {
            this._cursorPos = new Point();
            param1.addEventListener(MouseEvent.CLICK, this.mouseClick);
            param1.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMove);
            param1.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
            param1.addEventListener(MouseEvent.MOUSE_UP, this.mouseUp);
            return;
        }// end function

        private function mouseUp(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            this._cursorPos.x = event.stageX;
            this._cursorPos.y = event.stageY;
            var _loc_2:* = this.checkButtonArea(this._cursorPos.x, this._cursorPos.y);
            var _loc_3:* = this._aButton.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = this._aButton[_loc_3];
                if (_loc_4.isEnable() && areaCheck(_loc_2, _loc_4) && _loc_4.isHit(event.stageX, event.stageY))
                {
                    _loc_4.setMouseUp();
                    return;
                }
                _loc_3 = _loc_3 - 1;
            }
            this._bMouseDown = false;
            return;
        }// end function

        private function mouseDown(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            this._cursorPos.x = event.stageX;
            this._cursorPos.y = event.stageY;
            var _loc_2:* = this.checkButtonArea(this._cursorPos.x, this._cursorPos.y);
            var _loc_3:* = this._aButton.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = this._aButton[_loc_3];
                if (_loc_4.isEnable() && areaCheck(_loc_2, _loc_4) && _loc_4.isHit(event.stageX, event.stageY))
                {
                    _loc_4.setMouseDown();
                    return;
                }
                _loc_3 = _loc_3 - 1;
            }
            this._bMouseDown = true;
            return;
        }// end function

        private function mouseMove(event:MouseEvent) : void
        {
            this._cursorPos.x = event.stageX;
            this._cursorPos.y = event.stageY;
            this.updateHit();
            return;
        }// end function

        public function updateHit() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_1:* = this.checkButtonArea(this._cursorPos.x, this._cursorPos.y);
            _loc_3 = this._aButton.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_2 = this._aButton[_loc_3];
                if (_loc_2.isEnable() == false)
                {
                }
                else if (areaCheck(_loc_1, _loc_2) && _loc_2.isHit(this._cursorPos.x, this._cursorPos.y))
                {
                    _loc_2.setMouseOver();
                    break;
                }
                else
                {
                    _loc_2.setMouseOut();
                }
                _loc_3 = _loc_3 - 1;
            }
            _loc_3 = _loc_3 - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_2 = this._aButton[_loc_3];
                if (_loc_2.isEnable() == false)
                {
                }
                else
                {
                    _loc_2.setMouseOut();
                }
                _loc_3 = _loc_3 - 1;
            }
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = this.checkButtonArea(event.stageX, event.stageY);
            var _loc_3:* = this._aButton.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_5 = this._aButton[_loc_3];
                if (_loc_5.isEnable() && areaCheck(_loc_2, _loc_5) && _loc_5.isHit(event.stageX, event.stageY))
                {
                    _loc_5.setClick();
                    return;
                }
                _loc_3 = _loc_3 - 1;
            }
            for each (_loc_4 in this._aNoClickCallback)
            {
                
                this._loc_4();
            }
            return;
        }// end function

        public function addButton(param1:MovieClip, param2:Function, param3:int = -1) : ButtonBase
        {
            var _loc_4:* = new ButtonBase(param1, param2);
            if (param3 != Constant.UNDECIDED)
            {
                _loc_4.setId(param3);
            }
            this._aButton.push(_loc_4);
            return _loc_4;
        }// end function

        public function addButtonBase(param1:ButtonBase) : void
        {
            this._aButton.push(param1);
            return;
        }// end function

        public function addPushButton(param1:MovieClip, param2:int = -1) : ButtonBase
        {
            var _loc_3:* = new PushButton(param1);
            if (param2 != Constant.UNDECIDED)
            {
                _loc_3.setId(param2);
            }
            this._aButton.push(_loc_3);
            return _loc_3;
        }// end function

        public function removeArray(param1:ButtonBase) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aButton.length)
            {
                
                _loc_3 = this._aButton[_loc_2];
                if (_loc_3 == param1)
                {
                    this._aButton.splice(_loc_2, 1);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function removeButton(param1:ButtonBase) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aButton.length)
            {
                
                _loc_3 = this._aButton[_loc_2];
                if (_loc_3 == param1)
                {
                    _loc_3.release();
                    this._aButton.splice(_loc_2, 1);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function addNoClickBUtton(param1:Function) : void
        {
            this._aNoClickCallback.push(param1);
            return;
        }// end function

        public function isMouseOn() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = this.checkButtonArea(this._cursorPos.x, this._cursorPos.y);
            for each (_loc_2 in this._aButton)
            {
                
                if (areaCheck(_loc_1, _loc_2) && _loc_2.isHit(this._cursorPos.x, this._cursorPos.y))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function isMouseOnDragBlockButton() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = this.checkButtonArea(this._cursorPos.x, this._cursorPos.y);
            for each (_loc_2 in this._aButton)
            {
                
                if (_loc_2.isDragBlock() && areaCheck(_loc_1, _loc_2) && _loc_2.isHit(this._cursorPos.x, this._cursorPos.y))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function checkMouseOnEnableButton(param1:ButtonBase) : Boolean
        {
            var _loc_2:* = this.checkButtonArea(this._cursorPos.x, this._cursorPos.y);
            return param1.isEnable() && areaCheck(_loc_2, param1) && param1.isHit(this._cursorPos.x, this._cursorPos.y);
        }// end function

        public function push() : void
        {
            this._aButtonStack.push(this._aButton);
            this._aButton = [];
            this._aNoClickStack.push(this._aNoClickCallback);
            this._aNoClickCallback = new Array();
            return;
        }// end function

        public function pop() : void
        {
            if (this._aButtonStack.length > 0)
            {
                this._aButton = this._aButtonStack[0];
            }
            else
            {
                this._aButton = new Array();
            }
            this._aButtonStack.pop();
            if (this._aNoClickStack.length > 0)
            {
                this._aNoClickCallback = this._aNoClickStack[0];
            }
            else
            {
                this._aNoClickCallback = new Array();
            }
            this._aNoClickStack.pop();
            return;
        }// end function

        public function seal(param1:Array, param2:Boolean = false) : int
        {
            var _loc_3:* = null;
            this._aSealFlag.push(param2);
            for each (_loc_3 in this._aButton)
            {
                
                if (param1.indexOf(_loc_3) == -1)
                {
                    _loc_3.seal(param2);
                }
            }
            return this.sealCount;
        }// end function

        public function unseal() : void
        {
            var _loc_2:* = null;
            if (this._aSealFlag.length == 0)
            {
                return;
            }
            var _loc_1:* = this._aSealFlag.pop();
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.unseal(_loc_1);
            }
            return;
        }// end function

        public function clearSeal() : void
        {
            while (this._aSealFlag.length > 0)
            {
                
                this.unseal();
            }
            return;
        }// end function

        public function addButtonArea(param1:ButtonArea) : void
        {
            var _loc_2:* = this._aArea.indexOf(param1);
            if (_loc_2 < 0)
            {
                this._aArea.push(param1);
            }
            return;
        }// end function

        public function removeButtonArea(param1:ButtonArea) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aArea.length)
            {
                
                _loc_3 = this._aArea[_loc_2];
                if (_loc_3 == param1)
                {
                    _loc_3.release();
                    this._aArea.splice(_loc_2, 1);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function checkButtonArea(param1:Number, param2:Number) : ButtonArea
        {
            var _loc_4:* = null;
            var _loc_3:* = this._aArea.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = this._aArea[_loc_3];
                if (_loc_4.isEnable() && _loc_4.isHit(param1, param2))
                {
                    return _loc_4;
                }
                _loc_3 = _loc_3 - 1;
            }
            return null;
        }// end function

        public static function getInstance() : ButtonManager
        {
            if (_instance == null)
            {
                _instance = new ButtonManager;
            }
            return _instance;
        }// end function

        private static function areaCheck(param1:ButtonArea, param2:ButtonBase) : Boolean
        {
            return param1 == null || param1.hasButton(param2);
        }// end function

    }
}
