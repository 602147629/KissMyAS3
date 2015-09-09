package lovefox.unit
{
    import flash.display.*;
    import flash.events.*;
    import lovefox.isometric.*;

    public class Shell extends EventDispatcher
    {
        private var _poolPushed:Boolean = false;
        private var _enterframeListenerArray:Array;
        public var _mc:Sprite;
        public var _img:UnitClip;
        public var _x:Number;
        public var _y:Number;
        private var _gravity:Number;
        public var _speed:Number = 8;
        public var _zSpeed:Number = 8;
        var _angle:Object;
        var _obl:Object;
        public var _map:Map;
        private var _target:Object;
        private var _state:String = "fly";
        private var _data:Object;
        private var _pierce:Boolean;
        private var _hue:uint = 0;
        private var _z:Number;
        private var _targetRange:Number;
        private var _targetImgY:Number = 0;
        private static var _objectPool:Array = [];
        public static var _missleArray:Array = [];

        public function Shell(param1, param2, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8, param9)
        {
            this._data = param1;
            this._map = param2;
            this._speed = param8;
            this._x = param3;
            this._y = param4;
            this._z = param5;
            this._obl = param9;
            var _loc_10:* = Math.sqrt(Math.pow(param7 - param4, 2) + Math.pow(param6 - param3, 2));
            this._angle = Math.atan2(param7 - param4, param6 - param3);
            this._zSpeed = Math.tan(this._obl) * this._speed;
            var _loc_11:* = _loc_10 / param8;
            this._gravity = (-this._z - this._zSpeed * _loc_11) * 2 / _loc_11 / _loc_11;
            this._enterframeListenerArray = [];
            _missleArray.push(this);
            this.display(param2);
            this.launch();
            return;
        }// end function

        function startLoop(param1:Function)
        {
            if (this._mc != null)
            {
                this.stopLoop(param1);
                this._enterframeListenerArray.push(param1);
                if (this._enterframeListenerArray.length == 1)
                {
                    this._mc.addEventListener(Event.ENTER_FRAME, this.enterframeLoop);
                }
            }
            return;
        }// end function

        function stopLoop(param1:Function)
        {
            var _loc_2:* = undefined;
            if (this._mc != null)
            {
                _loc_2 = 0;
                while (_loc_2 < this._enterframeListenerArray.length)
                {
                    
                    if (this._enterframeListenerArray[_loc_2] == param1)
                    {
                        this._enterframeListenerArray.splice(_loc_2, 1);
                        break;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (this._enterframeListenerArray.length == 0)
                {
                    this._mc.removeEventListener(Event.ENTER_FRAME, this.enterframeLoop);
                }
            }
            return;
        }// end function

        private function enterframeLoop(param1)
        {
            var _loc_2:* = undefined;
            if (!Config.paused)
            {
                for (_loc_2 in this._enterframeListenerArray)
                {
                    
                    var _loc_5:* = this._enterframeListenerArray;
                    _loc_5.this._enterframeListenerArray[_loc_2](param1);
                }
            }
            if (this._enterframeListenerArray.length == 0)
            {
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterframeLoop);
            }
            return;
        }// end function

        function clearEnterframeLoop()
        {
            var _loc_1:* = undefined;
            this._enterframeListenerArray = [];
            if (this._mc != null)
            {
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterframeLoop);
            }
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            this._targetImgY = 0;
            this.stopLoop(this.subDisplay);
            this.clearEnterframeLoop();
            this._map.removeEventListener("complete", this.handleMapComplete);
            _loc_1 = 0;
            while (_loc_1 < _missleArray.length)
            {
                
                if (_missleArray[_loc_1] == this)
                {
                    _missleArray.splice(_loc_1, 1);
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
            this._img.zoff = -this._z;
            return;
        }// end function

        function move(event:Event)
        {
            this.directTo(this._angle);
            this._x = this._x + Math.cos(this._angle) * this._speed / Config.fps;
            this._y = this._y + Math.sin(this._angle) * this._speed / Config.fps;
            this._zSpeed = this._zSpeed + this._gravity / Config.fps;
            this._z = Math.max(0, this._z + this._zSpeed / Config.fps);
            this._img.zoff = this._z;
            this.draw();
            if (this._z <= 0 && this._zSpeed < 0)
            {
                this.over();
            }
            return;
        }// end function

        public function over()
        {
            var after:*;
            dispatchEvent(new Event("over"));
            this.stopLoop(this.move);
            if (this._img._ready && this._img.testAction("over"))
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

        public static function newShell(param1, param2, param3:Number, param4:Number, param5, param6, param7 = false, param8 = 0, param9 = 0)
        {
            return new Missle(param1, param2, param3, param4, param5, param6, param7, param8, param9);
        }// end function

        public static function destroyAll(param1 = null)
        {
            var _loc_2:* = _missleArray.concat();
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
            _missleArray = _loc_3;
            return;
        }// end function

    }
}
