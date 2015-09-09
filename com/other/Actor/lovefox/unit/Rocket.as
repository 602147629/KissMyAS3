package lovefox.unit
{
    import flash.display.*;
    import flash.events.*;

    public class Rocket extends EventDispatcher
    {
        private var _poolPushed:Boolean = false;
        private var _enterframeListenerArray:Array;
        public var _mc:Sprite;
        public var _img:UnitClip;
        public var _x:Number;
        public var _y:Number;
        public var _speed:Number = 8;
        var _angle:Number;
        public var _map:Object;
        public var _target:Object;
        private var _state:String = "fly";
        private var _data:Object;
        private var _acc:Number;
        private var _decay:Number;
        private var _z:Number;
        private var _targetRange:Number;
        private var _targetImgY:Number = 0;
        private var _hue:int = 0;
        private static var _objectPool:Array = [];
        public static var _rocketArray:Array = [];

        public function Rocket(param1, param2, param3:Number, param4:Number, param5, param6, param7, param8, param9, param10 = 0, param11 = 0)
        {
            this._target = param9;
            this._data = param1;
            this._x = param3;
            this._y = param4;
            this._z = param10;
            this._acc = param7;
            this._decay = param8;
            this._speed = param5;
            this._angle = param6;
            this._enterframeListenerArray = [];
            _rocketArray.push(this);
            this._map = param2;
            this._hue = param11;
            this.display(param2);
            this.launch();
            return;
        }// end function

        function startLoop(param1:Function)
        {
            this.stopLoop(param1);
            this._enterframeListenerArray.push(param1);
            this._mc.addEventListener(Event.ENTER_FRAME, param1, false, 0, true);
            return;
        }// end function

        function stopLoop(param1:Function)
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._enterframeListenerArray.length)
            {
                
                if (this._enterframeListenerArray[_loc_2] == param1)
                {
                    this._enterframeListenerArray.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this._mc.removeEventListener(Event.ENTER_FRAME, param1);
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            this._targetImgY = 0;
            this.stopLoop(this.subDisplay);
            this._map.removeEventListener("complete", this.handleMapComplete);
            _loc_2 = this._enterframeListenerArray.concat();
            _loc_1 = 0;
            while (_loc_1 < _loc_2.length)
            {
                
                this.stopLoop(_loc_2[_loc_1]);
                _loc_1 = _loc_1 + 1;
            }
            _loc_1 = 0;
            while (_loc_1 < _rocketArray.length)
            {
                
                if (_rocketArray[_loc_1] == this)
                {
                    _rocketArray.splice(_loc_1, 1);
                    break;
                }
                _loc_1 = _loc_1 + 1;
            }
            if (this._img != null)
            {
                this._img.destroy();
                this._img = null;
            }
            if (this._mc.parent != null)
            {
                this._mc.parent.removeChild(this._mc);
            }
            Config.clearDisplayList(this._mc);
            if (!this._poolPushed)
            {
                this._poolPushed = true;
                _objectPool.push(this);
            }
            return;
        }// end function

        public function display(param1)
        {
            this._map = param1;
            if (this._mc == null)
            {
                this._mc = new Sprite();
                this._mc.mouseEnabled = false;
                this._mc.mouseChildren = false;
            }
            this._img = UnitClip.newUnitClip(this._data, false, this._hue);
            this._img.addShadow(32, 0.2);
            if (this._img.testAction("fly"))
            {
                this.changeStateTo("fly");
            }
            else
            {
                this.changeStateTo("idle");
            }
            this._mc.addChild(this._img);
            if (this._map._state == "ready")
            {
                this.subDisplay();
            }
            else
            {
                this._map.addEventListener("complete", this.handleMapComplete);
            }
            return;
        }// end function

        private function handleMapComplete(param1)
        {
            this._map.removeEventListener("complete", this.handleMapComplete);
            this.startLoop(this.subDisplay);
            return;
        }// end function

        private function subDisplay(param1 = null)
        {
            this.stopLoop(this.subDisplay);
            this._map._rootMap.addChild(this._mc);
            this.draw();
            return;
        }// end function

        public function launch()
        {
            this.startLoop(this.move);
            this._targetRange = Math.sqrt(Math.pow(this._target._y - this._y, 2) + Math.pow(this._target._x - this._x, 2));
            this._img.zoff = -this._z;
            return;
        }// end function

        function move(event:Event)
        {
            var _loc_8:* = undefined;
            if (this._target == null)
            {
                this.destroy();
                return;
            }
            var _loc_2:* = Math.atan2(this._target._y - this._y, this._target._x - this._x);
            var _loc_3:* = _loc_2 - this._angle;
            if (_loc_3 > Math.PI)
            {
                _loc_3 = _loc_3 - Math.PI * 2;
            }
            else if (_loc_3 < -Math.PI)
            {
                _loc_3 = _loc_3 + Math.PI * 2;
            }
            _loc_3 = Math.abs(_loc_3) / Math.PI;
            var _loc_4:* = Math.cos(this._angle) * this._speed + Math.cos(_loc_2) * this._acc * (1 - _loc_3);
            var _loc_5:* = Math.sin(this._angle) * this._speed + Math.sin(_loc_2) * this._acc * (1 - _loc_3);
            this._angle = Math.atan2(_loc_5, _loc_4);
            this._speed = Math.sqrt(Math.pow(_loc_4, 2) + Math.pow(_loc_5, 2));
            this._speed = this._speed * this._decay;
            this.directTo(this._angle);
            var _loc_6:* = Math.sqrt(Math.pow(this._target._y - this._y, 2) + Math.pow(this._target._x - this._x, 2));
            if (this._target._img != null)
            {
                this._targetImgY = this._target._img.y;
            }
            var _loc_7:* = -((this._z - this._targetImgY) * _loc_6 / this._targetRange + this._targetImgY);
            if (!isNaN(_loc_7))
            {
                this._img.zoff = _loc_7;
            }
            if (this._img != null && this._img._ready)
            {
                _loc_8 = this._img._bitmapRectW / 2;
            }
            else
            {
                _loc_8 = 0;
            }
            if (_loc_6 > _loc_8 + this._speed / Config.fps)
            {
                this._x = this._x + Math.cos(this._angle) * this._speed / Config.fps;
                this._y = this._y + Math.sin(this._angle) * this._speed / Config.fps;
                this.draw();
            }
            else
            {
                this._x = this._x + Math.cos(this._angle) * (_loc_6 - _loc_8);
                this._y = this._y + Math.sin(this._angle) * (_loc_6 - _loc_8);
                this.draw();
                this.over();
            }
            return;
        }// end function

        public function over()
        {
            var after:*;
            this.stopLoop(this.move);
            if (this._img._ready && this._img.testAction("over") != null)
            {
                after = function ()
            {
                destroy();
                return;
            }// end function
            ;
                this.changeStateTo("over", after);
            }
            else
            {
                this.destroy();
            }
            return;
        }// end function

        public function draw()
        {
            var _loc_1:* = null;
            _loc_1 = {_x:this._x, _y:this._y};
            _loc_1 = this._map.mapToUnit(_loc_1);
            this._mc.x = _loc_1._x;
            this._mc.y = _loc_1._y;
            return;
        }// end function

        function directTo(param1)
        {
            if (param1 == undefined || param1 == null)
            {
                param1 = this._angle;
            }
            this._img.directTo(param1);
            return;
        }// end function

        function changeStateTo(param1:String, param2:Function = null)
        {
            this._state = param1;
            if (this._img != null)
            {
                this._img.changeStateTo(param1, param2);
            }
            return;
        }// end function

        public static function newRocket(param1, param2, param3:Number, param4:Number, param5, param6, param7, param8, param9, param10 = 0, param11 = 0)
        {
            var _loc_12:* = null;
            if (_objectPool.length == 0)
            {
                return new Rocket(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            }
            _loc_12 = _objectPool.shift();
            _loc_12._poolPushed = false;
            _loc_12._target = param9;
            _loc_12._data = param1;
            _loc_12._x = param3;
            _loc_12._y = param4;
            _loc_12._z = param10;
            _loc_12._acc = param7;
            _loc_12._decay = param8;
            _loc_12._speed = param5;
            _loc_12._angle = param6;
            _rocketArray.push(_loc_12);
            _loc_12._map = param2;
            _loc_12._hue = param11;
            _loc_12.display(param2);
            _loc_12.launch();
            return _loc_12;
        }// end function

        public static function destroyAll(param1 = null)
        {
            var _loc_2:* = _rocketArray.concat();
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                if (param1 == null || param1 == _loc_2[_loc_4]._map)
                {
                    _loc_2[_loc_4].destroy();
                }
                else
                {
                    _loc_3.push(_loc_2[_loc_4]);
                }
                _loc_4 = _loc_4 + 1;
            }
            _rocketArray = _loc_3;
            return;
        }// end function

    }
}
