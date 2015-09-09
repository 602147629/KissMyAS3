package lovefox.unit
{
    import flash.display.*;
    import flash.events.*;
    import lovefox.isometric.*;

    public class Effect extends EventDispatcher
    {
        private var _poolPushed:Boolean = false;
        private var _pushPoolTimer:Object;
        public var _map:Map;
        public var _mc:Sprite;
        public var _img:UnitClip;
        public var _effect:UnitClip;
        public var _buffEffect:Object;
        public var _x:Number;
        public var _y:Number;
        public var _layer:Number;
        public var _halo:Number;
        public var _shadow:Number;
        public var _state:String = "idle";
        public var _data:Object;
        public var _currTile:LogicalTile;
        public var _walkBlock:Boolean = false;
        public var _selectable:Boolean = false;
        public var _type:uint;
        private var _hue:uint = 0;
        private static var _objectPool:Array = [];
        public static var _effectArray:Array = [];

        public function Effect(param1, param2, param3, param4 = 0, param5 = 0, param6 = 0, param7 = 0)
        {
            this._buffEffect = {};
            this._hue = param7;
            this._data = param1;
            this._type = UNIT_TYPE_ENUM.TYPEID_EFFECT;
            this._x = param2;
            this._y = param3;
            this._layer = param4;
            this._halo = param5;
            this._shadow = param6;
            _effectArray.push(this);
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            Config.stopLoop(this.subDisplay);
            if (this._img != null)
            {
                this._img.removeEventListener("complete", this.handleImgComplete);
            }
            if (this._map != null)
            {
                this._map.removeEventListener("complete", this.handleMapComplete);
            }
            if (this._currTile != null)
            {
                this._currTile.removeUnit(this);
                this._currTile = null;
            }
            dispatchEvent(new Event("destroy"));
            this.visible = false;
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
            clearTimeout(this._pushPoolTimer);
            if (!this._poolPushed)
            {
                this._poolPushed = true;
                this._pushPoolTimer = setTimeout(this.pushPool, 1000);
            }
            return;
        }// end function

        private function pushPool()
        {
            clearTimeout(this._pushPoolTimer);
            _objectPool.push(this);
            return;
        }// end function

        public function over()
        {
            if (this._img != null && this._img._ready)
            {
                if (this._img.testAction("over"))
                {
                    this.changeStateTo("over", this.handleImgOverEnd);
                }
                else
                {
                    this.destroy();
                }
            }
            else
            {
                this.destroy();
            }
            return;
        }// end function

        private function handleImgOverEnd(param1 = null)
        {
            this.destroy();
            return;
        }// end function

        private function handleImgOver(param1 = null)
        {
            dispatchEvent(new Event("over"));
            return;
        }// end function

        public function replay()
        {
            if (this._img.testAction("idle"))
            {
                this.changeStateTo("idle", this.handleImgOver, true);
            }
            else
            {
                this.changeStateTo("fly", this.handleImgOver, true);
            }
            this._img.forceAnimation(0);
            this.draw();
            return;
        }// end function

        public function display(param1)
        {
            if (this._mc == null)
            {
                this._mc = new Sprite();
                this._mc.mouseEnabled = false;
                this._mc.mouseChildren = false;
            }
            this._img = UnitClip.newUnitClip(this._data, false, this._hue);
            if (this._shadow > 0)
            {
                this._img.addShadow(this._shadow, 0.2, true);
            }
            else if (this._shadow == -1)
            {
                this._img.shadow = true;
            }
            else
            {
                this._img.shadow = false;
            }
            this._img.data.parentEffect = this;
            if (this._img.testAction("idle"))
            {
                this.changeStateTo("idle", this.handleImgOver);
            }
            else
            {
                this.changeStateTo("fly", this.handleImgOver);
            }
            this._mc.addChild(this._img);
            if (this._img._ready)
            {
                this.imgComplete();
            }
            else
            {
                this._img.addEventListener("complete", this.handleImgComplete);
            }
            this._map = param1;
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

        public function move(param1, param2)
        {
            this._x = param1;
            this._y = param2;
            this.draw();
            return;
        }// end function

        public function set visible(param1:Boolean)
        {
            if (this._mc == null)
            {
                return;
            }
            if (param1)
            {
                if (this._mc.parent == null)
                {
                    if (this._layer == 0)
                    {
                        this._map._textMap.addChild(this._mc);
                    }
                    else if (this._layer == 1)
                    {
                        this._map._rootMap.addChild(this._mc);
                    }
                    else if (this._layer == 2)
                    {
                        this._map._footMap.addChild(this._mc);
                    }
                    else if (this._layer == 3)
                    {
                        this._map._rootMap.addChild(this._mc);
                    }
                }
            }
            else
            {
                if (this._mc.parent != null)
                {
                    this._mc.parent.removeChild(this._mc);
                }
                if (this._halo > 0)
                {
                    this._map.removeHalo(this);
                }
            }
            return;
        }// end function

        private function handleMapComplete(param1)
        {
            this._map.removeEventListener("complete", this.handleMapComplete);
            Config.startLoop(this.subDisplay);
            return;
        }// end function

        private function imgComplete()
        {
            this._img.removeEventListener("complete", this.handleMapComplete);
            if (this._data.hue != null)
            {
                this._img.setHue(this._data.hue);
            }
            return;
        }// end function

        private function handleImgComplete(param1)
        {
            param1.target.removeEventListener("complete", this.handleImgComplete);
            this.imgComplete();
            return;
        }// end function

        function subDisplay(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            Config.stopLoop(this.subDisplay);
            this.visible = true;
            if (this._layer == 3)
            {
                _loc_2 = this._map.mapToTile(this);
                _loc_3 = this._map._logicalTile[_loc_2._x][_loc_2._y];
                if (_loc_3 != this._currTile)
                {
                    if (this._currTile != null)
                    {
                        this._currTile.removeUnit(this);
                    }
                    this._currTile = _loc_3;
                    this._currTile.addUnit(this);
                }
            }
            this.draw();
            return;
        }// end function

        public function draw()
        {
            var _loc_1:* = null;
            if (this._map == null)
            {
                return;
            }
            _loc_1 = this._map.mapToUnit(this);
            this._mc.x = _loc_1._x;
            this._mc.y = _loc_1._y;
            if (this._halo > 0)
            {
                this._map.setHalo(this, this._halo, this._mc.x, this._mc.y);
            }
            return;
        }// end function

        public function directTo(param1)
        {
            var _loc_2:* = undefined;
            if (this._img != null)
            {
                this._img.directTo(param1);
            }
            return;
        }// end function

        public function changeStateTo(param1:String, param2:Function = null, param3 = false)
        {
            this._state = param1;
            if (this._img != null)
            {
                this._img.changeStateTo(param1, param2, param3);
            }
            return;
        }// end function

        public static function newEffect(param1, param2, param3, param4 = 0, param5 = 0, param6 = 0, param7 = 0)
        {
            var _loc_8:* = null;
            if (_objectPool.length == 0)
            {
                return new Effect(param1, param2, param3, param4, param5, param6, param7);
            }
            _loc_8 = _objectPool.shift();
            _loc_8._hue = param7;
            _loc_8._poolPushed = false;
            _loc_8._data = param1;
            _loc_8._x = param2;
            _loc_8._y = param3;
            _loc_8._layer = param4;
            _loc_8._halo = param5;
            _loc_8._shadow = param6;
            _effectArray.push(_loc_8);
            return _loc_8;
        }// end function

        public static function destroyAll(param1 = null)
        {
            var _loc_2:* = _effectArray.concat();
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
            _effectArray = _loc_3;
            return;
        }// end function

    }
}
