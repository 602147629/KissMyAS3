package lovefox.gameUI
{
    import flash.display.*;

    public class Particle extends Shape
    {
        private var _speedAcc:Object;
        private var _speed:Object;
        private var _angleAcc:Object;
        private var _angle:Object;
        private var _chaos:Object;
        private var _countTotal:Object;
        private var _count:Object;
        private var _beReceived:Boolean = false;
        private var _beReceivX:int;
        private var _beReceivY:int;
        private var _beReceivAcc:Number;
        private var _beReceivDecay:Number = 0.9;
        private var _beReceivFunc:Function;
        private var _beReceivStartDis:Number;
        private static var _objStack:Array = [];

        public function Particle()
        {
            return;
        }// end function

        public function init(param1, param2, param3, param4, param5, param6, param7, param8)
        {
            this._beReceived = false;
            this._beReceivFunc = null;
            this._chaos = param7;
            this._angleAcc = 0;
            this._speedAcc = 0;
            this._speed = param4 * (1 + (Math.random() - 0.5) * 2 * this._chaos);
            this._angle = param5;
            var _loc_9:* = int(param8 * 30 / 1000 * (1 + (Math.random() - 0.5) * 2 * this._chaos));
            this._count = int(param8 * 30 / 1000 * (1 + (Math.random() - 0.5) * 2 * this._chaos));
            this._countTotal = _loc_9;
            this.x = param1;
            this.y = param2;
            this.graphics.clear();
            this.graphics.beginFill(param6, 1);
            this.graphics.drawCircle(0, 0, param3 * (1 + (Math.random() - 0.5) * 2 * this._chaos));
            this.graphics.endFill();
            this.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            this.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            this.enterFrame();
            Config.stage.addChild(this);
            return;
        }// end function

        public function die()
        {
            Config.stage.removeChild(this);
            this.filters = [];
            this.graphics.clear();
            this.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            this.removeEventListener(Event.ENTER_FRAME, this.enterFrameR);
            if (this._beReceivFunc != null)
            {
                this._beReceivFunc();
            }
            _objStack.push(this);
            return;
        }// end function

        private function enterFrameR(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = Math.atan2(this._beReceivY - y, this._beReceivX - x);
            var _loc_4:* = Math.sqrt(Math.pow(this._beReceivX - x, 2) + Math.pow(this._beReceivY - y, 2));
            this.alpha = _loc_4 / this._beReceivStartDis;
            var _loc_5:* = _loc_3 - this._angle;
            if (_loc_3 - this._angle > Math.PI)
            {
                _loc_5 = _loc_5 - Math.PI * 2;
            }
            else if (_loc_5 < -Math.PI)
            {
                _loc_5 = _loc_5 + Math.PI * 2;
            }
            _loc_5 = Math.abs(_loc_5) / Math.PI;
            var _loc_6:* = Math.cos(this._angle) * this._speed + Math.cos(_loc_3) * this._beReceivAcc * (1 - _loc_5);
            var _loc_7:* = Math.sin(this._angle) * this._speed + Math.sin(_loc_3) * this._beReceivAcc * (1 - _loc_5);
            this._angle = Math.atan2(_loc_7, _loc_6);
            this._speed = Math.sqrt(Math.pow(_loc_6, 2) + Math.pow(_loc_7, 2));
            this._speed = this._speed * this._beReceivDecay;
            var _loc_8:* = Math.sqrt(Math.pow(this._beReceivY - y, 2) + Math.pow(this._beReceivX - x, 2));
            if (Math.sqrt(Math.pow(this._beReceivY - y, 2) + Math.pow(this._beReceivX - x, 2)) > this._speed)
            {
                x = x + Math.cos(this._angle) * this._speed;
                y = y + Math.sin(this._angle) * this._speed;
            }
            else
            {
                this.die();
            }
            return;
        }// end function

        private function enterFrame(param1 = null)
        {
            var _loc_2:* = this;
            var _loc_3:* = this._count - 1;
            _loc_2._count = _loc_3;
            if (!this._beReceived)
            {
                this.alpha = this._count / this._countTotal;
            }
            this._angleAcc = this._angleAcc + (Math.random() - 0.5) * this._chaos;
            this._angle = this._angle + this._angleAcc;
            this._speed = this._speed * (1 + (Math.random() - 0.5) * 2 * this._chaos);
            this.x = this.x + Math.cos(this._angle) * this._speed;
            this.y = this.y + Math.sin(this._angle) * this._speed;
            if (this._count <= 0)
            {
                if (!this._beReceived)
                {
                    this.die();
                }
                else
                {
                    this.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
                    this.removeEventListener(Event.ENTER_FRAME, this.enterFrameR);
                    this.addEventListener(Event.ENTER_FRAME, this.enterFrameR);
                    this._beReceivStartDis = Math.sqrt(Math.pow(this._beReceivX - x, 2) + Math.pow(this._beReceivY - y, 2));
                    this.enterFrameR();
                }
            }
            return;
        }// end function

        public function beReceive(param1, param2, param3, param4, param5 = null)
        {
            this._beReceived = true;
            this._beReceivX = param1;
            this._beReceivY = param2;
            this._beReceivAcc = param3;
            this._beReceivDecay = param4;
            this._beReceivFunc = param5;
            return;
        }// end function

        public static function create(param1, param2, param3 = 1, param4 = 1, param5 = 0, param6 = 16711680, param7 = 0, param8 = 1000)
        {
            var _loc_9:* = null;
            if (_objStack.length == 0)
            {
                _loc_9 = new Particle;
            }
            else
            {
                _loc_9 = _objStack.shift();
            }
            _loc_9.init(param1, param2, param3, param4, param5, param6, param7, param8);
            return _loc_9;
        }// end function

    }
}
