package quest
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import utility.*;

    public class QuestScrollBar extends Object
    {
        private const _SCROLL_MAX:Number = 50;
        private const _SCROLL_VALUE_SMALL:Number = 5;
        private const _SCROLL_VALUE_LARGE:Number = 100;
        private var _mc:MovieClip;
        private var _marker:MovieClip;
        private var _maxPoint:Point;
        private var _minPoint:Point;
        private var _accel:Number;
        private var _markerMinPos:Point;
        private var _markerMaxPos:Point;
        private var _nowPos:Point;
        private var _targetPos:Point;
        private var _scrollPos:Point;
        private var _bScroll:Boolean;
        private var _aButton:Array;
        private var _InputDrag:InputDrag;
        private var _gauge:Gauge;
        public static const SCROLL_UP:int = 1;
        public static const SCROLL_DOWN:int = 2;

        public function QuestScrollBar(param1:MovieClip, param2:Point, param3:Point)
        {
            this._mc = param1;
            this._marker = this._mc.barMc;
            this._maxPoint = param2;
            this._minPoint = param3;
            this._nowPos = new Point();
            this._targetPos = new Point();
            this._scrollPos = new Point();
            this._markerMaxPos = new Point(this._marker.x, this._marker.y);
            this._markerMinPos = new Point(this._marker.x, 50);
            var _loc_4:* = int(this._maxPoint.y - this._minPoint.y);
            this._gauge = new Gauge(this._mc.barGuid, _loc_4, 0);
            this._aButton = [];
            this._accel = 0;
            this.createButton();
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._mc && this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
                _loc_1.release();
            }
            this._aButton = [];
            if (this._InputDrag)
            {
                InputManager.getInstance().delDrag(this._InputDrag);
                this._InputDrag.release();
                this._InputDrag = null;
            }
            InputManager.getInstance().delMouseCallback(this);
            return;
        }// end function

        public function control() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = Constant.UNDECIDED;
            var _loc_2:* = InputManager.getInstance().corsor;
            for each (_loc_3 in this._aButton)
            {
                
                if (_loc_3.bPush == true)
                {
                    _loc_1 = _loc_3.id;
                    break;
                }
            }
            if (_loc_1 != Constant.UNDECIDED)
            {
                if (_loc_1 == SCROLL_DOWN)
                {
                    this._accel = this._accel + this._SCROLL_VALUE_SMALL;
                    if (this._accel > this._SCROLL_MAX)
                    {
                        this._accel = this._SCROLL_MAX;
                    }
                    this._scrollPos.y = this._scrollPos.y + this._accel;
                }
                if (_loc_1 == SCROLL_UP)
                {
                    this._accel = this._accel - this._SCROLL_VALUE_SMALL;
                    if (this._accel < -this._SCROLL_MAX)
                    {
                        this._accel = -this._SCROLL_MAX;
                    }
                    this._scrollPos.y = this._scrollPos.y + this._accel;
                }
            }
            else
            {
                this._accel = 0;
            }
            return;
        }// end function

        public function SetScrollPos(param1:Point) : void
        {
            this._scrollPos.x = param1.x;
            this._scrollPos.y = param1.y;
            this._accel = 0;
            return;
        }// end function

        public function update(param1:Point) : void
        {
            this._nowPos = param1;
            var _loc_2:* = this._maxPoint.y - this._minPoint.y;
            var _loc_3:* = param1.y - this._scrollPos.y - this._minPoint.y;
            var _loc_4:* = int(_loc_2 - _loc_3);
            if (int(_loc_2 - _loc_3) > _loc_2)
            {
                _loc_4 = _loc_2;
            }
            if (_loc_4 < 0)
            {
                _loc_4 = 0;
            }
            if (this._bScroll == true)
            {
                this._gauge.setGauge(_loc_4);
            }
            var _loc_5:* = Number((param1.y - this._minPoint.y) / (this._maxPoint.y - this._minPoint.y));
            var _loc_6:* = (this._markerMaxPos.y - this._markerMinPos.y) * _loc_5 + this._markerMinPos.y;
            this._marker.y = _loc_6;
            return;
        }// end function

        public function isMarkerPosMax() : Boolean
        {
            var _loc_1:* = Math.floor(this._markerMinPos.y);
            var _loc_2:* = Math.floor(this._marker.y);
            return (_loc_2 - 1) <= _loc_1;
        }// end function

        public function limitCheck(param1:Point) : void
        {
            this._targetPos.x = param1.x;
            this._targetPos.y = param1.y;
            if (param1.y >= this._minPoint.y)
            {
                if (param1.y + this._scrollPos.y < this._minPoint.y)
                {
                    this._scrollPos.y = this._minPoint.y - param1.y;
                }
            }
            if (param1.y <= this._maxPoint.y)
            {
                if (param1.y + this._scrollPos.y > this._maxPoint.y)
                {
                    this._scrollPos.y = this._maxPoint.y - param1.y;
                }
            }
            return;
        }// end function

        public function scrollReset() : void
        {
            if (this._scrollPos)
            {
                this._scrollPos.x = 0;
                this._scrollPos.y = 0;
            }
            else
            {
                this._scrollPos = new Point();
            }
            return;
        }// end function

        public function setButtonDisable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.setDisable(param1);
            }
            this._InputDrag.enable(!param1);
            InputManager.getInstance().enableMouseCallback(this, !param1);
            this._bScroll = param1;
            return;
        }// end function

        public function getPushButton(param1:int) : PushButton
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aButton)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function get maxPos() : Point
        {
            return this._maxPoint;
        }// end function

        public function get minPos() : Point
        {
            return this._minPoint;
        }// end function

        public function get scrollPos() : Point
        {
            return this._scrollPos;
        }// end function

        private function createButton() : void
        {
            var _loc_1:* = ButtonManager.getInstance().addPushButton(this._mc.upBtn, SCROLL_UP);
            var _loc_2:* = ButtonManager.getInstance().addPushButton(this._mc.downBtn, SCROLL_DOWN);
            _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
            _loc_2.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_1);
            this._aButton.push(_loc_2);
            this._InputDrag = new InputDrag(this, this._marker, null, this.cbMove, null, 1);
            InputManager.getInstance().addDrag(this._InputDrag);
            InputManager.getInstance().addMouseCallbackEx(this, null, this.cbClick, null, null, this.cbWheel);
            return;
        }// end function

        private function cbMove(event:MouseEvent) : void
        {
            var _loc_2:* = this._marker.parent.globalToLocal(new Point(event.stageX, event.stageY));
            var _loc_3:* = (_loc_2.y - this._markerMinPos.y) / (this._markerMaxPos.y - this._markerMinPos.y);
            if (_loc_3 > 1)
            {
                _loc_3 = 1;
            }
            if (_loc_3 < 0)
            {
                _loc_3 = 0;
            }
            var _loc_4:* = new Point(this._scrollPos.x, (this._maxPoint.y - this._minPoint.y) * _loc_3 + this._minPoint.y);
            new Point(this._scrollPos.x, (this._maxPoint.y - this._minPoint.y) * _loc_3 + this._minPoint.y).y = new Point(this._scrollPos.x, (this._maxPoint.y - this._minPoint.y) * _loc_3 + this._minPoint.y).y - this._targetPos.y;
            this.SetScrollPos(_loc_4);
            return;
        }// end function

        private function cbClick(event:MouseEvent) : void
        {
            var _loc_2:* = this._marker.parent.globalToLocal(new Point(event.stageX, event.stageY));
            var _loc_3:* = this._marker.getRect(this._marker.parent);
            if (_loc_3.left <= _loc_2.x && _loc_2.x <= _loc_3.right && this._markerMinPos.y <= _loc_2.y && _loc_2.y <= this._markerMaxPos.y)
            {
                this.cbMove(event);
            }
            return;
        }// end function

        private function cbWheel(event:MouseEvent) : void
        {
            this._scrollPos.y = this._scrollPos.y - this._SCROLL_VALUE_SMALL * event.delta;
            this._accel = 0;
            return;
        }// end function

    }
}
