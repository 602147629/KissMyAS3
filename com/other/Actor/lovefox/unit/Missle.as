package lovefox.unit
{
    import flash.display.*;
    import flash.events.*;
    import lovefox.isometric.*;

    public class Missle extends EventDispatcher
    {
        private var _poolPushed:Boolean = false;
        private var _enterframeListenerArray:Array;
        public var _mc:Sprite;
        public var _img:UnitClip;
        public var _x:Number;
        public var _y:Number;
        public var _preX:Number;
        public var _preY:Number;
        public var _speed:Number = 8;
        var _angle:Object;
        public var _map:Map;
        private var _target:Object;
        private var _state:String = "fly";
        private var _data:Object;
        private var _pierce:Boolean;
        private var _particleColor:uint = 0;
        private var _particleMode:uint = 0;
        private var _particleObj:Object;
        private var _hue:uint = 0;
        private var _z:Number;
        private var _targetRange:Number;
        private var _targetImgY:Number = 0;
        private static var _objectPool:Array = [];
        public static var _missleArray:Array = [];

        public function Missle(param1, param2, param3:Number, param4:Number, param5, param6, param7 = false, param8 = 0, param9 = 0)
        {
            this._hue = param8;
            this._target = param6;
            this._data = param1;
            this._preX = param3;
            this._preY = param4;
            this._x = param3;
            this._y = param4;
            this._z = param9;
            this._speed = param5;
            this._enterframeListenerArray = [];
            _missleArray.push(this);
            this._map = param2;
            this._pierce = param7;
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

        private function startParticle()
        {
            var _loc_1:* = new BitmapData(5, 5, true, 0);
            _loc_1.setPixel32(2, 2, 4280337400);
            var _loc_2:* = new GlowFilter(16777215, 1, 2, 2, 5, 1);
            _loc_1.applyFilter(_loc_1, _loc_1.rect, new Point(), _loc_2);
            this._particleObj = {tempY:this._img._yOff + this._img._height / 2, p:_loc_1, r:2, loop:Math.floor(Math.random() * 4) + 4, num:(Math.floor(Math.random() * 3) + 1), la:0, laSpeed:(Math.floor(Math.random() * 3) + 1) / 10, aSpeed:(Math.floor(Math.random() * 3) + 1) / 10, vSpeed:Math.floor(Math.random() * 5) + 3, mSpeed:(Math.floor(Math.random() * 4) - 1), lasting:3, count:0, over:false, pArray:[]};
            Config.startLoop(this.particleLoop);
            return;
        }// end function

        private function stopParticle()
        {
            if (this._particleObj != null)
            {
                this._particleObj.over = true;
            }
            return;
        }// end function

        private function particleLoop(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            if (this._particleObj != null)
            {
                var _loc_15:* = this._particleObj;
                var _loc_16:* = this._particleObj.count + 1;
                _loc_15.count = _loc_16;
                if (this._particleObj.count > this._particleObj.lasting)
                {
                    _loc_10 = 0;
                    while (_loc_10 < this._particleObj.loop * this._particleObj.num)
                    {
                        
                        _loc_9 = this._particleObj.pArray.shift();
                        this._map._textMap.removeChild(_loc_9.p);
                        _loc_10 = _loc_10 + 1;
                    }
                }
                if (this._particleObj.over)
                {
                    if (this._particleObj.pArray.length <= 0)
                    {
                        this._particleObj.p.dispose();
                        Config.stopLoop(this.particleLoop);
                    }
                }
                else
                {
                    _loc_10 = 0;
                    while (_loc_10 < this._particleObj.loop)
                    {
                        
                        _loc_3 = this._preX + (this._x - this._preX) / this._particleObj.loop * _loc_10;
                        _loc_4 = this._preY + (this._y - this._preY) / this._particleObj.loop * _loc_10;
                        _loc_5 = Math.atan2(this._y - this._preY, this._x - this._preX);
                        this._particleObj.la = this._particleObj.la + this._particleObj.laSpeed;
                        _loc_11 = 0;
                        while (_loc_11 < this._particleObj.num)
                        {
                            
                            _loc_14 = this._particleObj.la + Math.PI * 2 / this._particleObj.num * _loc_11;
                            _loc_2 = new Bitmap(this._particleObj.p);
                            _loc_8 = Math.sin(_loc_14) * this._particleObj.r;
                            _loc_9 = Math.cos(_loc_14) * this._particleObj.r;
                            _loc_6 = _loc_3 + Math.sin(_loc_5) * _loc_9;
                            _loc_7 = _loc_4 - Math.cos(_loc_5) * _loc_9;
                            _loc_12 = this._map.mapToUnit({_x:_loc_6, _y:_loc_7});
                            _loc_2.x = _loc_12._x - _loc_2.width / 2;
                            _loc_2.y = _loc_12._y + _loc_8 + this._particleObj.tempY - _loc_2.height / 2;
                            this._map._textMap.addChild(_loc_2);
                            this._particleObj.pArray.push({p:_loc_2, x:_loc_3, y:_loc_4, z:_loc_8, a:_loc_5, la:_loc_14, r:this._particleObj.r});
                            _loc_11 = _loc_11 + 1;
                        }
                        _loc_10 = _loc_10 + 1;
                    }
                    if (this._particleObj.aSpeed != 0 || this._particleObj.vSpeed != 0 || this._particleObj.mSpeed != 0)
                    {
                        _loc_10 = 0;
                        while (_loc_10 < this._particleObj.pArray.length)
                        {
                            
                            _loc_5 = this._particleObj.pArray[_loc_10].a;
                            if (this._particleObj.mSpeed != 0)
                            {
                                this._particleObj.pArray[_loc_10].la = this._particleObj.pArray[_loc_10].la + this._particleObj.aSpeed;
                            }
                            if (this._particleObj.vSpeed != 0)
                            {
                                this._particleObj.pArray[_loc_10].r = this._particleObj.pArray[_loc_10].r + this._particleObj.vSpeed;
                            }
                            if (this._particleObj.mSpeed != 0)
                            {
                                this._particleObj.pArray[_loc_10].x = this._particleObj.pArray[_loc_10].x - this._particleObj.mSpeed * Math.cos(_loc_5);
                                this._particleObj.pArray[_loc_10].y = this._particleObj.pArray[_loc_10].y - this._particleObj.mSpeed * Math.sin(_loc_5);
                            }
                            _loc_8 = Math.sin(this._particleObj.pArray[_loc_10].la) * this._particleObj.pArray[_loc_10].r;
                            _loc_9 = Math.cos(this._particleObj.pArray[_loc_10].la) * this._particleObj.pArray[_loc_10].r;
                            _loc_6 = this._particleObj.pArray[_loc_10].x + Math.sin(_loc_5) * _loc_9;
                            _loc_7 = this._particleObj.pArray[_loc_10].y - Math.cos(_loc_5) * _loc_9;
                            _loc_12 = this._map.mapToUnit({_x:_loc_6, _y:_loc_7});
                            this._particleObj.pArray[_loc_10].p.x = _loc_12._x - this._particleObj.pArray[_loc_10].p.width / 2;
                            this._particleObj.pArray[_loc_10].p.y = _loc_12._y + this._particleObj.pArray[_loc_10].z + this._img._yOff + this._img._height / 2 - this._particleObj.pArray[_loc_10].p.height / 2;
                            _loc_10 = _loc_10 + 1;
                        }
                    }
                }
            }
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
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (this._target == null)
            {
                this.destroy();
                return;
            }
            this._preX = this._x;
            this._preY = this._y;
            if ((this._target._y - this._y != 0 || this._target._x - this._x != 0) && (!this._pierce || this._angle == null))
            {
                this._angle = Math.atan2(this._target._y - this._y, this._target._x - this._x);
            }
            this.directTo(this._angle);
            var _loc_2:* = Math.sqrt(Math.pow(this._target._y - this._y, 2) + Math.pow(this._target._x - this._x, 2));
            if (this._target._img != null)
            {
                this._targetImgY = this._target._img.y;
            }
            var _loc_3:* = -((this._z - this._targetImgY) * _loc_2 / this._targetRange + this._targetImgY);
            if (!isNaN(_loc_3))
            {
                this._img.zoff = _loc_3;
            }
            if (this._img != null && this._img._ready)
            {
                _loc_4 = this._img._bitmapRectW / 2;
            }
            else
            {
                _loc_4 = 0;
            }
            if (_loc_2 > this._speed / Config.fps + _loc_4 || this._pierce)
            {
                this._x = this._x + Math.cos(this._angle) * this._speed / Config.fps;
                this._y = this._y + Math.sin(this._angle) * this._speed / Config.fps;
                _loc_5 = this._map.mapToScreen(this);
                if (_loc_5._x < 0 || _loc_5._x > this._map.width || _loc_5._y < 0 || _loc_5._y > this._map.height)
                {
                    dispatchEvent(new Event("over"));
                    this.destroy();
                }
                else
                {
                    this.draw();
                }
            }
            else
            {
                this._x = this._x + Math.cos(this._angle) * (_loc_2 - _loc_4);
                this._y = this._y + Math.sin(this._angle) * (_loc_2 - _loc_4);
                this.draw();
                this.over();
            }
            return;
        }// end function

        public function over()
        {
            var after:*;
            this.stopParticle();
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

        public static function newMissle(param1, param2, param3:Number, param4:Number, param5, param6, param7 = false, param8 = 0, param9 = 0)
        {
            var _loc_10:* = null;
            if (_objectPool.length == 0)
            {
                return new Missle(param1, param2, param3, param4, param5, param6, param7, param8, param9);
            }
            _loc_10 = _objectPool.shift();
            _loc_10._poolPushed = false;
            _loc_10._hue = param8;
            _loc_10._target = param6;
            _loc_10._data = param1;
            _loc_10._x = param3;
            _loc_10._y = param4;
            _loc_10._z = param9;
            _loc_10._speed = param5;
            _missleArray.push(_loc_10);
            _loc_10._map = param2;
            _loc_10._pierce = param7;
            _loc_10.display(param2);
            _loc_10.launch();
            return _loc_10;
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
