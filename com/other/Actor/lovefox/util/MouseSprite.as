package lovefox.util
{
    import flash.display.*;
    import flash.filters.*;

    public class MouseSprite extends Sprite
    {
        private var _clickTimer:Object;
        private var _dragTimer:Object;
        private var _preClickPt:Object = null;
        private var _normalFilter:Array;
        private var _warnCount:Object;
        private var _warnPosArray:Array;
        private var _warnFilterArray:Array;

        public function MouseSprite()
        {
            this.enableMouse = true;
            return;
        }// end function

        public function startWarn()
        {
            this._warnCount = 0;
            this._normalFilter = this.filters;
            this._warnPosArray = [];
            this._warnFilterArray = [];
            if (parent != null)
            {
                parent.addChild(this);
            }
            addEventListener(Event.ENTER_FRAME, this.warnLoop);
            return;
        }// end function

        public function warnLoop(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            if (this._warnCount % 2 == 0)
            {
                if (this._warnCount % 6 == 0)
                {
                    _loc_3 = new GlowFilter(16711680, 1, 0, 0, 5);
                }
                else if (this._warnCount % 6 == 2)
                {
                    _loc_3 = new GlowFilter(10027008, 1, 0, 0, 5);
                }
                else if (this._warnCount % 6 == 4)
                {
                    _loc_3 = new GlowFilter(3342336, 1, 0, 0, 5);
                }
                this._warnFilterArray.unshift(_loc_3);
                this._warnPosArray.unshift(this._warnCount);
            }
            _loc_3 = this._warnFilterArray[0];
            _loc_3.blurX = _loc_3.blurX + 2;
            _loc_3.blurY = _loc_3.blurY + 2;
            if (this._warnCount - this._warnPosArray[(this._warnPosArray.length - 1)] > 10)
            {
                this._warnFilterArray.pop();
                this._warnPosArray.pop();
            }
            else if (this._warnCount - this._warnPosArray[(this._warnPosArray.length - 1)] > 8)
            {
                _loc_3 = this._warnFilterArray[(this._warnFilterArray.length - 1)];
                _loc_3.strength = _loc_3.strength - 2;
                _loc_3.alpha = _loc_3.alpha - 0.5;
            }
            this.filters = this._normalFilter.concat(this._warnFilterArray);
            var _loc_4:* = this;
            var _loc_5:* = this._warnCount + 1;
            _loc_4._warnCount = _loc_5;
            return;
        }// end function

        public function stopWarn()
        {
            removeEventListener(Event.ENTER_FRAME, this.warnLoop);
            this.filters = this._normalFilter;
            return;
        }// end function

        public function set enableMouse(param1:Boolean) : void
        {
            if (param1)
            {
                removeEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseDown);
                removeEventListener(MouseEvent.MOUSE_UP, this.handleMouseUp);
                addEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseDown);
                addEventListener(MouseEvent.MOUSE_UP, this.handleMouseUp);
            }
            else
            {
                removeEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseDown);
                removeEventListener(MouseEvent.MOUSE_UP, this.handleMouseUp);
            }
            return;
        }// end function

        private function handleMouseOut(param1)
        {
            removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
            removeEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
            clearTimeout(this._dragTimer);
            this._preClickPt = null;
            dispatchEvent(new MouseEvent("drag"));
            return;
        }// end function

        private function handleMouseDown(param1)
        {
            if (this._preClickPt == null)
            {
                this._preClickPt = {_x:mouseX, _y:mouseY};
                this._dragTimer = setTimeout(this.dragTimerFunc, 200);
                addEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
                addEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
            }
            else
            {
                clearTimeout(this._clickTimer);
                this._preClickPt = null;
                dispatchEvent(new MouseEvent("dblClick"));
            }
            return;
        }// end function

        private function handleMouseMove(param1)
        {
            if (this._preClickPt != null && (Math.abs(this._preClickPt._x - mouseX) > 3 && Math.abs(this._preClickPt._x - mouseY) > 3) || this._preClickPt == null)
            {
                removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
                removeEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
                clearTimeout(this._dragTimer);
                this._preClickPt = null;
                dispatchEvent(new MouseEvent("drag"));
            }
            return;
        }// end function

        private function handleMouseUp(param1)
        {
            removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
            removeEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
            clearTimeout(this._dragTimer);
            if (this._preClickPt != null)
            {
                this._clickTimer = setTimeout(this.clickTimerFunc, 100);
            }
            else
            {
                this._preClickPt = null;
                dispatchEvent(new MouseEvent("up"));
            }
            return;
        }// end function

        private function clickTimerFunc()
        {
            dispatchEvent(new MouseEvent("sglClick"));
            clearTimeout(this._clickTimer);
            this._preClickPt = null;
            return;
        }// end function

        private function dragTimerFunc()
        {
            removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
            removeEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
            clearTimeout(this._dragTimer);
            this._preClickPt = null;
            dispatchEvent(new MouseEvent("drag"));
            return;
        }// end function

    }
}
