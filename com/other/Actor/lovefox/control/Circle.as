package lovefox.control
{
    import flash.display.*;

    public class Circle extends Sprite
    {
        private var _form:uint = 0;
        private var _param1:uint = 0;
        private var _param2:uint = 0;
        private var _angle:Number = 0;

        public function Circle()
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this.scaleY = 0.5;
            return;
        }// end function

        public function set form(param1)
        {
            this._form = param1;
            return;
        }// end function

        public function get form()
        {
            return this._form;
        }// end function

        public function set param1(param1)
        {
            this._param1 = param1;
            return;
        }// end function

        public function get param1()
        {
            return this._param1;
        }// end function

        public function set param2(param1)
        {
            this._param2 = param1;
            return;
        }// end function

        public function get param2()
        {
            return this._param2;
        }// end function

        public function set angle(param1)
        {
            this._angle = param1 + Math.PI / 4;
            return;
        }// end function

        public function get angle()
        {
            return this._angle;
        }// end function

        public function start()
        {
            this.clear();
            this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        public function clear()
        {
            this.graphics.clear();
            this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        private function onEnterFrame(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            this.graphics.clear();
            this.graphics.beginFill(16777215, 0.2);
            if (this._form == 1 || this._form == 2)
            {
                _loc_2 = this._angle;
                _loc_3 = this._angle + Math.PI / 3;
                _loc_4 = this._angle + Math.PI / 3 * 2;
                _loc_5 = this._angle + Math.PI;
                _loc_6 = this._angle + Math.PI / 3 * 4;
                _loc_7 = this._angle + Math.PI / 3 * 5;
                this._angle = this._angle + 0.02;
                this.graphics.drawCircle(0, 0, this._param1);
                this.graphics.moveTo(Math.cos(_loc_2) * this._param1, Math.sin(_loc_2) * this._param1);
                this.graphics.lineTo(Math.cos(_loc_4) * this._param1, Math.sin(_loc_4) * this._param1);
                this.graphics.lineTo(Math.cos(_loc_6) * this._param1, Math.sin(_loc_6) * this._param1);
                this.graphics.lineTo(Math.cos(_loc_2) * this._param1, Math.sin(_loc_2) * this._param1);
                this.graphics.moveTo(Math.cos(_loc_3) * this._param1, Math.sin(_loc_3) * this._param1);
                this.graphics.lineTo(Math.cos(_loc_5) * this._param1, Math.sin(_loc_5) * this._param1);
                this.graphics.lineTo(Math.cos(_loc_7) * this._param1, Math.sin(_loc_7) * this._param1);
                this.graphics.lineTo(Math.cos(_loc_3) * this._param1, Math.sin(_loc_3) * this._param1);
            }
            else if (this._form == 3)
            {
                _loc_4 = this.param2 / 180 * Math.PI;
                _loc_2 = this._angle - _loc_4 / 2;
                _loc_3 = this._angle + _loc_4 / 2;
                this.graphics.moveTo(0, 0);
                this.graphics.lineTo(Math.cos(_loc_2) * this._param1, Math.sin(_loc_2) * this._param1);
                _loc_8 = Math.ceil(Math.abs(_loc_4) / (Math.PI / 4));
                _loc_9 = _loc_4 / _loc_8;
                _loc_10 = _loc_2;
                _loc_12 = 1;
                while (_loc_12 <= _loc_8)
                {
                    
                    _loc_10 = _loc_10 + _loc_9;
                    _loc_11 = _loc_10 - _loc_9 / 2;
                    this.graphics.curveTo(this._param1 / Math.cos(_loc_9 / 2) * Math.cos(_loc_11), this._param1 / Math.cos(_loc_9 / 2) * Math.sin(_loc_11), this._param1 * Math.cos(_loc_10), this._param1 * Math.sin(_loc_10));
                    _loc_12 = _loc_12 + 1;
                }
                this.graphics.lineTo(0, 0);
            }
            else if (this._form == 4)
            {
                _loc_2 = this._angle - this._param2 / 180 * Math.PI / 2;
                _loc_3 = this._angle + this._param2 / 180 * Math.PI / 2;
                this.graphics.moveTo(Math.cos(this._angle - Math.PI / 2) * this._param2, Math.sin(this._angle - Math.PI / 2) * this._param2);
                this.graphics.lineTo(Math.cos(this._angle - Math.PI / 2) * this._param2 + Math.cos(this._angle) * this._param1, Math.sin(this._angle - Math.PI / 2) * this._param2 + Math.sin(this._angle) * this._param1);
                this.graphics.lineTo(Math.cos(this._angle + Math.PI / 2) * this._param2 + Math.cos(this._angle) * this._param1, Math.sin(this._angle + Math.PI / 2) * this._param2 + Math.sin(this._angle) * this._param1);
                this.graphics.lineTo(Math.cos(this._angle + Math.PI / 2) * this._param2, Math.sin(this._angle + Math.PI / 2) * this._param2);
                this.graphics.lineTo(Math.cos(this._angle - Math.PI / 2) * this._param2, Math.sin(this._angle - Math.PI / 2) * this._param2);
            }
            this.graphics.endFill();
            return;
        }// end function

    }
}
