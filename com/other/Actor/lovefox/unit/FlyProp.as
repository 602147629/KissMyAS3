package lovefox.unit
{
    import flash.events.*;

    public class FlyProp extends Unit
    {
        private var _poolPushed:Boolean = false;
        var _minDamage:int;
        var _maxDamage:int;
        private var _r:Object;
        private var _owner:Object;
        public var _overFlagInterval:Object;
        public var _overFlag:Object = false;
        private var _hue:int = 0;
        public static var _objectPool:Array = [];
        public static var _flyPropStack:Array = [];

        public function FlyProp(param1, param2, param3, param4, param5, param6, param7, param8 = null, param9 = 0)
        {
            super(param3, param4, param5, param1, param2);
            this._owner = param8;
            _type = param1;
            _id = param2;
            _data = param3;
            _x = param4;
            _y = param5;
            this._r = 1;
            _angle = param6;
            _speed = param7;
            this._hue = param9;
            _enterframeListenerArray = [];
            return;
        }// end function

        override public function display(param1)
        {
            _map = param1;
            if (_mc == null)
            {
                _mc = new Sprite();
                _mc.mouseEnabled = false;
                _mc.mouseChildren = false;
            }
            _img = UnitClip.newUnitClip(_data, false, this._hue);
            changeStateTo("idle");
            _mc.addChild(_img);
            if (_map._state == "ready")
            {
                this.subDisplay();
            }
            else
            {
                _map.addEventListener("complete", this.handleMapComplete);
            }
            return;
        }// end function

        private function handleMapComplete(param1)
        {
            _map.removeEventListener("complete", this.handleMapComplete);
            startLoop(this.subDisplay);
            return;
        }// end function

        override function subDisplay(param1 = null)
        {
            stopLoop(this.subDisplay);
            _map._rootMap.addChild(_mc);
            draw();
            return;
        }// end function

        private function enterframeLoop(param1)
        {
            var _loc_2:* = undefined;
            if (!Config.paused)
            {
                for (_loc_2 in _enterframeListenerArray)
                {
                    
                    var _loc_5:* = _enterframeListenerArray;
                    _loc_5._enterframeListenerArray[_loc_2](param1);
                }
            }
            if (_enterframeListenerArray.length == 0)
            {
                _mc.removeEventListener(Event.ENTER_FRAME, this.enterframeLoop);
            }
            return;
        }// end function

        override public function destroy()
        {
            this._hue = 0;
            if (_map != null)
            {
                _map.removeEventListener("complete", this.handleMapComplete);
                _map = null;
            }
            stopLoop(this.move);
            clearTimeout(this._overFlagInterval);
            super.destroy();
            if (!this._poolPushed)
            {
                this._poolPushed = true;
                _objectPool.push(this);
            }
            return;
        }// end function

        public function launch()
        {
            startLoop(this.move);
            return;
        }// end function

        public function set overFlag(param1)
        {
            this._overFlag = param1;
            if (this._overFlag)
            {
                clearTimeout(this._overFlagInterval);
                this._overFlagInterval = setTimeout(this.doOver, 300);
            }
            return;
        }// end function

        private function doOver()
        {
            clearTimeout(this._overFlagInterval);
            this.over();
            return;
        }// end function

        function move(event:Event)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            directTo(null);
            var _loc_2:* = _x + Math.cos(_angle) * _speed / Config.fps;
            var _loc_3:* = _y + Math.sin(_angle) * _speed / Config.fps;
            if (_loc_2 >= 1 && _loc_2 < _map._logicalWidth * Map._ptPerTile / 2 - 1 && _loc_3 >= 1 && _loc_3 < _map._logicalHeight * Map._ptPerTile / 2 - 1)
            {
                _loc_4 = _map.mapToTile({_x:_loc_2, _y:_loc_3});
                if (_loc_4 == null || _loc_4._parentTile._walkable == 0)
                {
                    this.over();
                    return;
                }
                if (this._overFlag)
                {
                    _loc_5 = Math.max(1, Math.floor(this._r / (Map._ptPerTile / 2)));
                    _loc_6 = -_loc_5;
                    while (_loc_6 < (_loc_5 + 1))
                    {
                        
                        _loc_7 = -_loc_5;
                        while (_loc_7 < (_loc_5 + 1))
                        {
                            
                            _loc_10 = _loc_4._x + _loc_6;
                            _loc_11 = _loc_4._y + _loc_7;
                            if (_loc_10 >= 0 && _loc_10 < _map._logicalWidth)
                            {
                                if (_loc_11 >= 0 && _loc_11 < _map._logicalHeight)
                                {
                                    _loc_8 = 0;
                                    while (_loc_8 < _map._logicalTile[_loc_10][_loc_11]._currUnit.length)
                                    {
                                        
                                        _loc_9 = _map._logicalTile[_loc_10][_loc_11]._currUnit[_loc_8];
                                        if (_loc_9 != this._owner)
                                        {
                                            this.over();
                                            return;
                                        }
                                        _loc_8 = _loc_8 + 1;
                                    }
                                }
                            }
                            _loc_7 = _loc_7 + 1;
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                }
                _x = _loc_2;
                _y = _loc_3;
                draw();
            }
            else
            {
                this.over();
            }
            return;
        }// end function

        public function over()
        {
            var after:*;
            clearTimeout(this._overFlagInterval);
            if (_map != null && _img != null && _img.testAction("over"))
            {
                stopLoop(this.move);
                after = function ()
            {
                destroy();
                return;
            }// end function
            ;
                changeStateTo("over", after);
            }
            else
            {
                this.destroy();
            }
            return;
        }// end function

        public static function newFlyProp(param1, param2, param3, param4, param5, param6, param7, param8 = null, param9 = 0)
        {
            var _loc_10:* = null;
            if (_objectPool.length == 0)
            {
                return new FlyProp(param1, param2, param3, param4, param5, param6, param7, param8, param9);
            }
            _loc_10 = _objectPool.shift();
            _loc_10._poolPushed = false;
            _loc_10._owner = param8;
            _loc_10._type = param1;
            _loc_10._id = param2;
            if (_unitStack[_loc_10._type] == null)
            {
                _unitStack[_loc_10._type] = {};
            }
            _unitStack[_loc_10._type][_loc_10._id] = _loc_10;
            _loc_10._data = param3;
            _loc_10._x = param4;
            _loc_10._y = param5;
            _loc_10._r = 1;
            _loc_10._angle = param6;
            _loc_10._speed = param7;
            _loc_10._hue = param9;
            var _loc_12:* = _allCount + 1;
            _allCount = _loc_12;
            return _loc_10;
        }// end function

    }
}
