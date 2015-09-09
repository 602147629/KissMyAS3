package lovefox.isometric
{

    public class Tile extends Object
    {
        public var _map:Map;
        public var _x:int;
        public var _y:int;
        public var _xDraw:int;
        public var _yDraw:int;
        public var _tileTableID:int;
        public var _tileID:int = -1;
        public var _obstacleTableID:int;
        public var _obstacleID:int = -1;
        public var _obstacleY:int;
        var _tileY:int;
        public var _tLabel:Object = "";
        public var _oLabel:Object = "";
        public var _flaged:Boolean = false;
        public var _changed:Boolean = false;
        public var _tilePicUrl:String = "";
        public var _tileWalkable:int = 2;
        public var _obstaclePicUrl:String = "";
        public var _obstacleWalkable:int = 2;
        public var _obstacleCutable:int = 0;
        public var _obstacleBlock:int = 1;
        public var _obstacleWidth:int = 0;
        public var _obstacleHeight:int = 0;
        public var _object:ObjectClip = null;
        public var _tempTileIndex:int = 1;
        public var _tempObstacleIndex:int = 1;
        public var _tempObjectIndex:int = -1;
        public var _shadow:uint = 0;
        public var _ground:uint = 0;
        public var _hard:uint;
        public var _haloRadius:Object;
        public var _haloType:Object = 0;
        public var _haloX:Object;
        public var _haloY:Object;
        public var _haloBmpd:Object;
        public var _x_up_lock:Boolean = false;
        public var _x_down_lock:Boolean = false;
        public var _y_up_lock:Boolean = false;
        public var _y_down_lock:Boolean = false;
        public var _walkable:Object = 2;
        private var _block:Object = 2;
        private var _fillInnerOpen:Object;
        private var _fillInnerClose:Object;
        public static var _walkableLevel:Object = 2;

        public function Tile(param1:uint, param2:uint, param3:Map)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            this._x = param1;
            this._y = param2;
            this._tileY = 0;
            this._map = param3;
            this._xDraw = (this._x - this._y) * Map._ptPerTile - Map._ptPerTile;
            this._yDraw = (this._x / 2 + this._y / 2) * Map._ptPerTile - Map._ptPerTile / 2;
            _loc_4 = 0;
            while (_loc_4 < 2)
            {
                
                _loc_5 = 0;
                while (_loc_5 < 2)
                {
                    
                    if (param1 >= this._map._exBorder && param2 >= this._map._exBorder && param1 < this._map._width - this._map._earthBorder && param2 < this._map._height - this._map._earthBorder)
                    {
                        this._map._logicalTile[(param1 - this._map._exBorder) * 2 + _loc_4][(param2 - this._map._exBorder) * 2 + _loc_5] = new LogicalTile((param1 - this._map._exBorder) * 2 + _loc_4, (param2 - this._map._exBorder) * 2 + _loc_5, this);
                    }
                    _loc_5 = _loc_5 + 1;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function set fillInnerOpen(param1)
        {
            this._fillInnerOpen = param1;
            return;
        }// end function

        public function get fillInnerOpen()
        {
            return this._fillInnerOpen;
        }// end function

        public function set fillInnerClose(param1)
        {
            this._fillInnerClose = param1;
            return;
        }// end function

        public function get fillInnerClose()
        {
            return this._fillInnerClose;
        }// end function

        public function modifyPt(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = this._map.tileToMap(this);
            var _loc_4:* = {_x:param1._x, _y:param1._y};
            if (this._x > 0)
            {
                _loc_3 = this._map._tile[(this._x - 1)][this._y];
                if (_loc_3._obstacleWalkable < 2)
                {
                    if (param1._x < _loc_2._x)
                    {
                        _loc_4._x = _loc_2._x;
                    }
                }
            }
            if (this._y > 0)
            {
                _loc_3 = this._map._tile[this._x][(this._y - 1)];
                if (_loc_3._obstacleWalkable < 2)
                {
                    if (param1._y < _loc_2._y)
                    {
                        _loc_4._y = _loc_2._y;
                    }
                }
            }
            if (this._x > 0 && this._y > 0)
            {
                _loc_3 = this._map._tile[(this._x - 1)][(this._y - 1)];
                if (_loc_3._obstacleWalkable < 2)
                {
                    if (param1._x < _loc_2._x)
                    {
                        _loc_4._x = _loc_2._x;
                    }
                    if (param1._y < _loc_2._y)
                    {
                        _loc_4._y = _loc_2._y;
                    }
                }
            }
            if (this._x < (this._map._width - 1))
            {
                _loc_3 = this._map._tile[(this._x + 1)][this._y];
                if (_loc_3._obstacleWalkable < 2)
                {
                    if (param1._x > _loc_2._x)
                    {
                        _loc_4._x = _loc_2._x;
                    }
                }
            }
            if (this._y < (this._map._height - 1))
            {
                _loc_3 = this._map._tile[this._x][(this._y + 1)];
                if (_loc_3._obstacleWalkable < 2)
                {
                    if (param1._y > _loc_2._y)
                    {
                        _loc_4._y = _loc_2._y;
                    }
                }
            }
            if (this._x < (this._map._width - 1) && this._y < (this._map._height - 1))
            {
                _loc_3 = this._map._tile[(this._x + 1)][(this._y + 1)];
                if (_loc_3._obstacleWalkable < 2)
                {
                    if (param1._x > _loc_2._x)
                    {
                        _loc_4._x = _loc_2._x;
                    }
                    if (param1._y > _loc_2._y)
                    {
                        _loc_4._y = _loc_2._y;
                    }
                }
            }
            return _loc_4;
        }// end function

        public function get walkable()
        {
            if (this._walkable >= _walkableLevel)
            {
                return true;
            }
            return false;
        }// end function

        public function get walkableValue()
        {
            return Math.min(this._block, this._walkable);
        }// end function

        public function set walkableValue(param1)
        {
            this._walkable = param1;
            return;
        }// end function

        public function get block()
        {
            return this._block;
        }// end function

        public function set block(param1)
        {
            this._block = param1;
            return;
        }// end function

        public function set walkable(param1)
        {
            this._walkable = param1;
            return;
        }// end function

        public function destroy()
        {
            if (this._object != null)
            {
                this._object.destroy();
            }
            if (this._haloBmpd != null)
            {
                this._haloBmpd.dispose();
                this._haloBmpd = null;
            }
            this._haloRadius = null;
            this._haloType = 0;
            this._haloX = null;
            this._haloY = null;
            this._haloBmpd = null;
            this._tileTableID = null;
            this._tileID = -1;
            this._obstacleID = -1;
            this._obstacleY = 0;
            this._tileY = 0;
            this._tLabel = "";
            this._oLabel = "";
            this._flaged = false;
            this._changed = false;
            this._tilePicUrl = "";
            this._tileWalkable = 2;
            this._obstaclePicUrl = "";
            this._obstacleWalkable = 2;
            this._obstacleCutable = 0;
            this._obstacleBlock = 1;
            this._obstacleWidth = 0;
            this._obstacleHeight = 0;
            this._object = null;
            this._tempTileIndex = 1;
            this._tempObstacleIndex = 1;
            this._tempObjectIndex = -1;
            this._shadow = 0;
            this._ground = 0;
            this._hard = null;
            this._haloRadius = null;
            this._x_up_lock = false;
            this._x_down_lock = false;
            this._y_up_lock = false;
            this._y_down_lock = false;
            this._walkable = 2;
            this._block = 2;
            this._fillInnerOpen = null;
            this._fillInnerClose = null;
            return;
        }// end function

    }
}
