package lovefox.isometric
{
    import lovefox.astar.*;

    public class LogicalTile extends Tile
    {
        public var _x:int;
        public var _y:int;
        public var _currUnit:Array;
        public var _currItem:Array;
        public var _captureUnit:Object;
        public var _parentTile:Object;
        private var _map:Map;
        private var _jumpTile:Object;
        private var _jumpTileClosed:Boolean;
        public static var _justTerrain:Boolean = false;
        public static var _walkableLevel:Object = 2;

        public function LogicalTile(param1:uint, param2:uint, param3 = null)
        {
            super(param2, param1);
            this._currUnit = [];
            this._currItem = [];
            this._x = param1;
            this._y = param2;
            this._parentTile = param3;
            this._map = this._parentTile._map;
            return;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this._jumpTileClosed = false;
            return;
        }// end function

        public function set jumpTileClosed(param1:Boolean) : void
        {
            this._jumpTileClosed = param1;
            return;
        }// end function

        public function get jumpTileClosed() : Boolean
        {
            return this._jumpTileClosed;
        }// end function

        public function set jumpTile(param1:LogicalTile) : void
        {
            this._jumpTile = param1;
            return;
        }// end function

        public function get jumpTile() : LogicalTile
        {
            return this._jumpTile;
        }// end function

        public function modifyPt(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = this._map.tileToMap(this);
            var _loc_4:* = {_x:param1._x, _y:param1._y};
            if (this._x > 0)
            {
                _loc_3 = this._map._logicalTile[(this._x - 1)][this._y];
                if (_loc_3._parentTile._obstacleWalkable < 2)
                {
                    if (param1._x < _loc_2._x)
                    {
                        _loc_4._x = _loc_2._x;
                    }
                }
            }
            else
            {
                _loc_4._x = _loc_2._x;
            }
            if (this._y > 0)
            {
                _loc_3 = this._map._logicalTile[this._x][(this._y - 1)];
                if (_loc_3._parentTile._obstacleWalkable < 2)
                {
                    if (param1._y < _loc_2._y)
                    {
                        _loc_4._y = _loc_2._y;
                    }
                }
            }
            else
            {
                _loc_4._y = _loc_2._y;
            }
            if (this._x > 0 && this._y > 0)
            {
                _loc_3 = this._map._logicalTile[(this._x - 1)][(this._y - 1)];
                if (_loc_3._parentTile._obstacleWalkable < 2)
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
            if (this._x < (this._map._logicalWidth - 1))
            {
                _loc_3 = this._map._logicalTile[(this._x + 1)][this._y];
                if (_loc_3._parentTile._obstacleWalkable < 2)
                {
                    if (param1._x > _loc_2._x)
                    {
                        _loc_4._x = _loc_2._x;
                    }
                }
            }
            else
            {
                _loc_4._x = _loc_2._x;
            }
            if (this._y < (this._map._logicalHeight - 1))
            {
                _loc_3 = this._map._logicalTile[this._x][(this._y + 1)];
                if (_loc_3._parentTile._obstacleWalkable < 2)
                {
                    if (param1._y > _loc_2._y)
                    {
                        _loc_4._y = _loc_2._y;
                    }
                }
            }
            else
            {
                _loc_4._y = _loc_2._y;
            }
            if (this._x < (this._map._logicalWidth - 1) && this._y < (this._map._logicalHeight - 1))
            {
                _loc_3 = this._map._logicalTile[(this._x + 1)][(this._y + 1)];
                if (_loc_3._parentTile._obstacleWalkable < 2)
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

        public function get terrainwalkable()
        {
            if (this.parentWalkable >= _walkableLevel)
            {
                return true;
            }
            return false;
        }// end function

        public function get parentWalkable()
        {
            var _loc_1:* = this._parentTile.walkableValue;
            return _loc_1;
        }// end function

        public function get walkable()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            if (_justTerrain)
            {
                return this.parentWalkable >= _walkableLevel;
            }
            if (this._map._type == 0)
            {
                _loc_2 = false;
                _loc_1 = 0;
                while (_loc_1 < this._currUnit.length)
                {
                    
                    if (this._currUnit[_loc_1]._type != UNIT_TYPE_ENUM.TYPEID_PLAYER)
                    {
                        if (this._currUnit[_loc_1] != Config.player && (this._currUnit[_loc_1]._walkBlock && !(this._currUnit[_loc_1].type == UNIT_TYPE_ENUM.TYPEID_NPC && this._currItem.length > 0)))
                        {
                            _loc_2 = true;
                            break;
                        }
                    }
                    _loc_1 = _loc_1 + 1;
                }
                if (this.parentWalkable >= _walkableLevel && !_loc_2)
                {
                    return true;
                }
                return false;
            }
            else
            {
                _loc_2 = false;
                _loc_1 = 0;
                while (_loc_1 < this._currUnit.length)
                {
                    
                    if (this._currUnit[_loc_1]._walkBlock)
                    {
                        _loc_2 = true;
                        break;
                    }
                    _loc_1 = _loc_1 + 1;
                }
                if (this.parentWalkable >= _walkableLevel && !_loc_2)
                {
                    return true;
                }
                return false;
            }
        }// end function

        public function set walkable(param1)
        {
            this._parentTile.walkableValue = param1;
            return;
        }// end function

        public function destroy()
        {
            this._currUnit = [];
            this._currItem = [];
            this._captureUnit = null;
            this._jumpTile = null;
            _walkable = 2;
            return;
        }// end function

        public function addItem(param1)
        {
            this.removeItem(param1);
            this._currItem.push(param1);
            return;
        }// end function

        public function addUnit(param1)
        {
            this.removeUnit(param1);
            this._currUnit.push(param1);
            return;
        }// end function

        public function removeItem(param1)
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._currItem.length)
            {
                
                if (this._currItem[_loc_2] == param1)
                {
                    this._currItem.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function removeUnit(param1)
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._currUnit.length)
            {
                
                if (this._currUnit[_loc_2] == param1)
                {
                    this._currUnit.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function getMinCurrDepthItem(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_3:* = this._currItem.concat();
            while (_loc_3.length > 0 && (_loc_3[0]._mc == null || _loc_3[0]._mc.parent == null || _loc_3[0] == param1))
            {
                
                _loc_3.shift();
            }
            if (_loc_3.length == 0)
            {
                return null;
            }
            if (_loc_3.length == 1)
            {
                return _loc_3[0];
            }
            _loc_4 = _loc_3[0];
            _loc_5 = _loc_3[0]._mc.parent.getChildIndex(_loc_3[0]._mc);
            _loc_2 = 1;
            while (_loc_2 < _loc_3.length)
            {
                
                if (_loc_3[_loc_2] != param1 && _loc_3[_loc_2]._mc != null && _loc_3[_loc_2]._mc.parent != null)
                {
                    _loc_6 = _loc_3[_loc_2]._mc.parent.getChildIndex(_loc_3[_loc_2]._mc);
                    if (_loc_5 > _loc_6)
                    {
                        _loc_5 = _loc_6;
                        _loc_4 = _loc_3[_loc_2];
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_4;
        }// end function

        public function getMaxCurrDepthItem(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_3:* = this._currItem.concat();
            while (_loc_3.length > 0 && (_loc_3[0]._mc == null || _loc_3[0]._mc.parent == null || _loc_3[0] == param1))
            {
                
                _loc_3.shift();
            }
            if (_loc_3.length == 0)
            {
                return null;
            }
            if (_loc_3.length == 1)
            {
                return _loc_3[0];
            }
            _loc_4 = _loc_3[0];
            _loc_5 = _loc_3[0]._mc.parent.getChildIndex(_loc_3[0]._mc);
            _loc_2 = 1;
            while (_loc_2 < _loc_3.length)
            {
                
                if (_loc_3[_loc_2] != param1 && _loc_3[_loc_2]._mc != null && _loc_3[_loc_2]._mc.parent != null)
                {
                    _loc_6 = _loc_3[_loc_2]._mc.parent.getChildIndex(_loc_3[_loc_2]._mc);
                    if (_loc_5 < _loc_6)
                    {
                        _loc_5 = _loc_6;
                        _loc_4 = _loc_3[_loc_2];
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_4;
        }// end function

        public function get captureUnit()
        {
            return this._currUnit[0];
        }// end function

        public function getMinCurrDepthUnit(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_3:* = this._currUnit.concat();
            while (_loc_3.length > 0 && (_loc_3[0]._mc == null || _loc_3[0]._mc.parent == null || _loc_3[0] == param1))
            {
                
                _loc_3.shift();
            }
            if (_loc_3.length == 0)
            {
                return null;
            }
            if (_loc_3.length == 1)
            {
                return _loc_3[0];
            }
            _loc_4 = _loc_3[0];
            _loc_5 = _loc_3[0]._mc.parent.getChildIndex(_loc_3[0]._mc);
            _loc_2 = 1;
            while (_loc_2 < _loc_3.length)
            {
                
                if (_loc_3[_loc_2] != param1 && _loc_3[_loc_2]._mc != null && _loc_3[_loc_2]._mc.parent != null)
                {
                    _loc_6 = _loc_3[_loc_2]._mc.parent.getChildIndex(_loc_3[_loc_2]._mc);
                    if (_loc_5 > _loc_6)
                    {
                        _loc_5 = _loc_6;
                        _loc_4 = _loc_3[_loc_2];
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_4;
        }// end function

        public function getMaxCurrDepthUnit(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_3:* = this._currUnit.concat();
            while (_loc_3.length > 0 && (_loc_3[0]._mc == null || _loc_3[0]._mc.parent == null || _loc_3[0] == param1))
            {
                
                _loc_3.shift();
            }
            if (_loc_3.length == 0)
            {
                return null;
            }
            if (_loc_3.length == 1)
            {
                return _loc_3[0];
            }
            _loc_4 = _loc_3[0];
            _loc_5 = _loc_3[0]._mc.parent.getChildIndex(_loc_3[0]._mc);
            _loc_2 = 1;
            while (_loc_2 < _loc_3.length)
            {
                
                if (_loc_3[_loc_2] != param1 && _loc_3[_loc_2]._mc != null && _loc_3[_loc_2]._mc.parent != null)
                {
                    _loc_6 = _loc_3[_loc_2]._mc.parent.getChildIndex(_loc_3[_loc_2]._mc);
                    if (_loc_5 < _loc_6)
                    {
                        _loc_5 = _loc_6;
                        _loc_4 = _loc_3[_loc_2];
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_4;
        }// end function

    }
}
