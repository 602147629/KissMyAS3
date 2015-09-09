package lovefox.component
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;

    public class ToggleButtonBarUI extends Sprite
    {
        private var btnarr:Array;

        public function ToggleButtonBarUI(param1:Array)
        {
            this.btnarr = param1;
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            _loc_2 = 0;
            while (_loc_2 < this.btnarr.length)
            {
                
                _loc_3 = this.getchildbtn(_loc_2);
                this.addChild(_loc_3);
                this.btnarr[_loc_2].sort = false;
                _loc_3.x = _loc_1;
                _loc_1 = _loc_1 + this.btnarr[_loc_2].len;
                _loc_3.addEventListener(MouseEvent.CLICK, this.create(this.sendsort, _loc_2));
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function getchildbtn(param1:int) : Sprite
        {
            var _loc_2:* = null;
            _loc_2 = new Sprite();
            var _loc_3:* = new Shape();
            _loc_3.graphics.beginFill(6902422, 0.9);
            _loc_3.graphics.lineStyle(1, 4338526);
            _loc_3.graphics.drawRoundRect(0, 0, this.btnarr[param1].len, 20, 0);
            _loc_3.graphics.endFill();
            _loc_3.alpha = 0.7;
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.create(this.rollover, _loc_3));
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.create(this.rollout, _loc_3));
            _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, this.create(this.mousedown, _loc_3));
            _loc_2.addEventListener(MouseEvent.MOUSE_UP, this.create(this.rollover, _loc_3));
            _loc_2.addChild(_loc_3);
            if (this.btnarr[param1].hasOwnProperty("topmc"))
            {
                _loc_2.addChild(this.btnarr[param1].topmc);
            }
            var _loc_4:* = new Label(_loc_2, 5, 2, this.btnarr[param1].label);
            new Label(_loc_2, 5, 2, this.btnarr[param1].label).x = (this.btnarr[param1].len - _loc_4.width) / 2;
            return _loc_2;
        }// end function

        private function rollover(event:Event, param2:Shape) : void
        {
            param2.alpha = 0.9;
            return;
        }// end function

        private function rollout(event:Event, param2:Shape) : void
        {
            param2.alpha = 0.7;
            return;
        }// end function

        private function mousedown(event:Event, param2:Shape) : void
        {
            param2.alpha = 0.9;
            return;
        }// end function

        private function sendsort(event:MouseEvent, param2:uint) : void
        {
            trace(param2);
            if (this.btnarr[param2].sort)
            {
                this.btnarr[param2].sort = false;
            }
            else
            {
                this.btnarr[param2].sort = true;
            }
            var _loc_3:* = new AccTreeEvent(AccTreeEvent.TOGGLE_SELECT);
            var _loc_4:* = new Object();
            new Object().i = param2;
            _loc_4.label = this.btnarr[param2].label;
            _loc_4.fuc = this.btnarr[param2].fuc;
            _loc_4.sort = this.btnarr[param2].sort;
            _loc_3.typeobj = _loc_4;
            this.dispatchEvent(_loc_3);
            return;
        }// end function

        private function create(param1:Function, ... args) : Function
        {
            args = new activation;
            var F:Boolean;
            var f:* = param1;
            var arg:* = args;
            F;
            var _f:* = function (param1) : void
            {
                var _loc_2:* = arg;
                if (!F)
                {
                    F = true;
                    _loc_2.unshift(param1);
                }
                f.apply(null, _loc_2);
                return;
            }// end function
            ;
            return ;
        }// end function

    }
}
