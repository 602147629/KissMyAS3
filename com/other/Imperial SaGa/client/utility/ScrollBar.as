package utility
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;

    public class ScrollBar extends Object
    {
        private const _SCROLL_SPD_MAX:Number = 50;
        private const _SCROLL_ACCEL_SMALL:Number = 5;
        private var _mcBase:MovieClip;
        private var _marker:MovieClip;
        private var _isoMain:InStayOut;
        private var _cbScroll:Function;
        private var _maxScroll:Number;
        private var _curScroll:Number;
        private var _accel:Number;
        private var _bEnable:Boolean;
        private var _bInternalEnable:Boolean;
        private var _aButton:Array;
        private var _InputDrag:InputDrag;
        private var _bDrag:Boolean;
        private var _sealCount:int;
        public static const SCROLL_UP:int = 1;
        public static const SCROLL_DOWN:int = 2;

        public function ScrollBar(param1:MovieClip, param2:Function)
        {
            this._mcBase = param1;
            this._marker = this._mcBase.scrollBerMc.barMc;
            this._isoMain = new InStayOut(this._mcBase);
            this._cbScroll = param2;
            this._maxScroll = 0;
            this._curScroll = 0;
            this._accel = 0;
            this._bEnable = false;
            this._bInternalEnable = false;
            this._aButton = [];
            var _loc_3:* = new PushButton(this._mcBase.scrollBerMc.upBtn);
            _loc_3.setId(SCROLL_UP);
            _loc_3.enterSeId = ButtonBase.SE_CURSOR_ID;
            ButtonManager.getInstance().addButtonBase(_loc_3);
            this._aButton.push(_loc_3);
            var _loc_4:* = new PushButton(this._mcBase.scrollBerMc.downBtn);
            new PushButton(this._mcBase.scrollBerMc.downBtn).setId(SCROLL_DOWN);
            _loc_4.enterSeId = ButtonBase.SE_CURSOR_ID;
            ButtonManager.getInstance().addButtonBase(_loc_4);
            this._aButton.push(_loc_4);
            this._InputDrag = new InputDrag(this, this._marker, this.cbDrag, this.cbMove, this.cbDrop);
            InputManager.getInstance().addDrag(this._InputDrag);
            InputManager.getInstance().addMouseCallbackEx(this, null, this.cbClick, null, null, this.cbWheel);
            this._bDrag = false;
            this._sealCount = 0;
            this.updateEnable();
            return;
        }// end function

        public function get curScroll() : int
        {
            return this._curScroll;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            while (this._sealCount > 0)
            {
                
                ButtonManager.getInstance().unseal();
                var _loc_2:* = this;
                var _loc_3:* = this._sealCount - 1;
                _loc_2._sealCount = _loc_3;
            }
            if (this._InputDrag)
            {
                InputManager.getInstance().delDrag(this._InputDrag);
                this._InputDrag.release();
                this._InputDrag = null;
            }
            InputManager.getInstance().delMouseCallback(this);
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_1);
                _loc_1.release();
            }
            this._aButton = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            this._cbScroll = null;
            this._marker = null;
            this._mcBase = null;
            return;
        }// end function

        public function control() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = Constant.UNDECIDED;
            for each (_loc_2 in this._aButton)
            {
                
                if (_loc_2.bPush == true)
                {
                    _loc_1 = _loc_2.id;
                    break;
                }
            }
            if (_loc_1 != Constant.UNDECIDED)
            {
                if (_loc_1 == SCROLL_DOWN)
                {
                    this._accel = this._accel + this._SCROLL_ACCEL_SMALL;
                    if (this._accel > this._SCROLL_SPD_MAX)
                    {
                        this._accel = this._SCROLL_SPD_MAX;
                    }
                    this._curScroll = this._curScroll + this._accel;
                    if (this._curScroll > this._maxScroll)
                    {
                        this._curScroll = this._maxScroll;
                    }
                }
                if (_loc_1 == SCROLL_UP)
                {
                    this._accel = this._accel - this._SCROLL_ACCEL_SMALL;
                    if (this._accel < -this._SCROLL_SPD_MAX)
                    {
                        this._accel = -this._SCROLL_SPD_MAX;
                    }
                    this._curScroll = this._curScroll + this._accel;
                    if (this._curScroll < 0)
                    {
                        this._curScroll = 0;
                    }
                }
                this.updateMarker();
            }
            else
            {
                this._accel = 0;
            }
            if (this._sealCount > 0 && this._bDrag == false)
            {
                while (this._sealCount > 0)
                {
                    
                    ButtonManager.getInstance().unseal();
                    var _loc_3:* = this;
                    var _loc_4:* = this._sealCount - 1;
                    _loc_3._sealCount = _loc_4;
                }
            }
            return;
        }// end function

        public function open() : void
        {
            if (!this._isoMain.bOpened && !this._isoMain.bAnimetionOpen)
            {
                this._isoMain.setIn(function () : void
            {
                setInternalEnable(true);
                return;
            }// end function
            );
            }
            else
            {
                this.setInternalEnable(true);
            }
            return;
        }// end function

        public function close() : void
        {
            this.setInternalEnable(false);
            this._isoMain.setOut();
            return;
        }// end function

        public function setMaxScroll(param1:int) : void
        {
            this._maxScroll = param1;
            this.setScrollPos(this._curScroll);
            this.updateEnable();
            return;
        }// end function

        public function setScrollPos(param1:int) : void
        {
            this._curScroll = param1;
            if (this._curScroll > this._maxScroll)
            {
                this._curScroll = this._maxScroll;
            }
            if (this._curScroll < 0)
            {
                this._curScroll = 0;
            }
            this._accel = 0;
            this.updateMarker();
            return;
        }// end function

        private function updateMarker() : void
        {
            var _loc_1:* = this._mcBase.scrollBerMc.scrollAmbit.getRect(this._mcBase.scrollBerMc);
            var _loc_2:* = 0;
            if (this._maxScroll > 0)
            {
                _loc_2 = this._curScroll / this._maxScroll;
            }
            this._marker.y = _loc_1.height * _loc_2 + _loc_1.top;
            if (this._cbScroll != null)
            {
                this._cbScroll();
            }
            return;
        }// end function

        public function setEnable(param1:Boolean) : void
        {
            this._bEnable = param1;
            this.updateEnable();
            return;
        }// end function

        private function setInternalEnable(param1:Boolean) : void
        {
            this._bInternalEnable = param1;
            this.updateEnable();
            return;
        }// end function

        private function updateEnable() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this._bEnable && this._bInternalEnable && this._maxScroll > 0;
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.setDisable(!_loc_1);
            }
            this._marker.visible = _loc_1;
            if (this._InputDrag)
            {
                this._InputDrag.enable(_loc_1);
            }
            InputManager.getInstance().enableMouseCallback(this, _loc_1);
            return;
        }// end function

        private function cbDrag(event:MouseEvent) : void
        {
            this._bDrag = true;
            ButtonManager.getInstance().seal([]);
            var _loc_2:* = this;
            var _loc_3:* = this._sealCount + 1;
            _loc_2._sealCount = _loc_3;
            return;
        }// end function

        private function cbMove(event:MouseEvent) : void
        {
            var _loc_2:* = this._mcBase.scrollBerMc.globalToLocal(new Point(event.stageX, event.stageY));
            var _loc_3:* = this._mcBase.scrollBerMc.scrollAmbit.getRect(this._mcBase.scrollBerMc);
            var _loc_4:* = (_loc_2.y - _loc_3.top) / _loc_3.height;
            if ((_loc_2.y - _loc_3.top) / _loc_3.height > 1)
            {
                _loc_4 = 1;
            }
            if (_loc_4 < 0)
            {
                _loc_4 = 0;
            }
            var _loc_5:* = this._maxScroll * _loc_4;
            this.setScrollPos(_loc_5);
            return;
        }// end function

        private function cbDrop(event:MouseEvent) : void
        {
            this._bDrag = false;
            return;
        }// end function

        private function cbClick(event:MouseEvent) : void
        {
            var _loc_2:* = this._mcBase.scrollBerMc.globalToLocal(new Point(event.stageX, event.stageY));
            var _loc_3:* = this._mcBase.scrollBerMc.scrollAmbit.getRect(this._mcBase.scrollBerMc);
            if (_loc_3.left <= _loc_2.x && _loc_2.x <= _loc_3.right && _loc_3.top <= _loc_2.y && _loc_2.y <= _loc_3.bottom)
            {
                this.cbMove(event);
            }
            return;
        }// end function

        private function cbWheel(event:MouseEvent) : void
        {
            this.setScrollPos(this._curScroll - this._SCROLL_ACCEL_SMALL * event.delta);
            return;
        }// end function

    }
}
