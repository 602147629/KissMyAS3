package lovefox.astar
{
    import lovefox.isometric.*;

    public class Astar extends Object
    {
        private var startPoint:Array;
        private var endPoint:Array;
        private var map:Array;
        private var mapH:Number;
        private var mapW:Number;
        private var heap:BinaryHeap;
        private var mf:Function;
        private var clippingMode:String = "semi";
        public static var standardCost:Number = 1;
        public static var diagonalCost:Number = 1.414;

        public function Astar()
        {
            this.map = [];
            this.mf = Math.floor;
            return;
        }// end function

        public function setMap(param1:Array) : void
        {
            this.map = param1;
            this.mapW = this.map[0].length;
            this.mapH = this.map.length;
            return;
        }// end function

        public function newMap(param1:Number, param2:Number) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            param1 = this.mf(param1);
            param2 = this.mf(param2);
            this.map = new Array(param2);
            var _loc_3:* = param2;
            while (_loc_3-- > 0)
            {
                
                this.map[_loc_3] = new Array(param1);
                _loc_4 = param1;
                while (_loc_4-- > 0)
                {
                    
                    _loc_5 = new LogicalTile(_loc_4, _loc_3);
                    this.map[_loc_3][_loc_4] = _loc_5;
                }
            }
            this.mapW = param1;
            this.mapH = param2;
            return;
        }// end function

        public function setStartPoint(param1:Number, param2:Number) : void
        {
            this.startPoint = new Array(param1, param2);
            return;
        }// end function

        public function setClipping(param1:String) : void
        {
            this.clippingMode = param1;
            return;
        }// end function

        public function setEndPoint(param1:Number, param2:Number) : void
        {
            this.endPoint = new Array(param1, param2);
            return;
        }// end function

        public function findPath(param1:Boolean = true) : Array
        {
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = undefined;
            var _loc_14:* = null;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            this.openMap();
            if (!this.ready())
            {
                return [];
            }
            this.heap = new BinaryHeap();
            var _loc_2:* = false;
            var _loc_3:* = this.map[this.startPoint[1]][this.startPoint[0]];
            _loc_3.setOpen();
            _loc_3.setG(0);
            _loc_3.setH(this.endPoint[0], this.endPoint[1]);
            _loc_3.setParent(_loc_3);
            this.heap.addToHeap(_loc_3);
            while (this.heap.getLength() > 0 && !_loc_2)
            {
                
                _loc_9 = this.heap.getLowest();
                if (_loc_9.x == this.endPoint[0] && _loc_9.y == this.endPoint[1])
                {
                    _loc_2 = true;
                    break;
                }
                _loc_9.setClosed();
                _loc_10 = this.findSurroundingTiles(_loc_9);
                _loc_11 = _loc_10.length;
                while (_loc_11-- > 0)
                {
                    
                    if (!_loc_10[_loc_11].getOpen())
                    {
                        _loc_10[_loc_11].setOpen();
                        _loc_10[_loc_11].setParent(_loc_9);
                        _loc_10[_loc_11].setH(this.endPoint[0], this.endPoint[1]);
                        _loc_10[_loc_11].setG(_loc_9.getG());
                        this.heap.addToHeap(_loc_10[_loc_11]);
                        continue;
                    }
                    _loc_12 = _loc_10[_loc_11].getH() + _loc_9.getG() + _loc_10[_loc_11].getCost();
                    if (_loc_12 < _loc_10[_loc_11].getF())
                    {
                        _loc_13 = _loc_10[_loc_11].id;
                        _loc_10[_loc_11].setParent(_loc_9);
                        _loc_10[_loc_11].setG(_loc_9.getG());
                        this.heap.updateList(this.heap.getPosition(_loc_13));
                    }
                }
            }
            if (!_loc_2)
            {
                return [];
            }
            var _loc_4:* = new Array();
            var _loc_5:* = this.endPoint[0];
            var _loc_6:* = this.endPoint[1];
            this.map[_loc_6][_loc_5].notice();
            _loc_4.push(this.map[_loc_6][_loc_5]);
            var _loc_7:* = this.map[_loc_6][_loc_5].getParent();
            _loc_5 = this.map[_loc_6][_loc_5].getParent().x;
            _loc_6 = _loc_7.y;
            while (_loc_5 != this.startPoint[0] || _loc_6 != this.startPoint[1])
            {
                
                _loc_14 = this.map[_loc_6][_loc_5];
                _loc_4.push(_loc_14);
                _loc_14.notice();
                _loc_7 = _loc_14.getParent();
                _loc_5 = _loc_7.x;
                _loc_6 = _loc_7.y;
            }
            _loc_4.push(this.map[this.startPoint[1]][this.startPoint[0]]);
            this.map[this.startPoint[1]][this.startPoint[0]].notice();
            _loc_4.reverse();
            if (param1)
            {
                if (_loc_4.length > 0)
                {
                    _loc_15 = [];
                    _loc_16 = _loc_4[0];
                    _loc_15.push(_loc_16);
                    _loc_8 = 1;
                    while (_loc_8 < _loc_4.length)
                    {
                        
                        if (!this.getPoint(_loc_16, _loc_4[_loc_8], 0))
                        {
                            _loc_16 = _loc_4[(_loc_8 - 1)];
                            _loc_15.push(_loc_16);
                        }
                        _loc_8 = _loc_8 + 1;
                    }
                    _loc_15.push(_loc_4[(_loc_4.length - 1)]);
                    _loc_4 = _loc_15;
                }
            }
            return _loc_4;
        }// end function

        public function testStraight(param1, param2)
        {
            var sp:* = param1;
            var ep:* = param2;
            try
            {
                if (this.getPoint(sp, ep, 0))
                {
                    return true;
                }
            }
            catch (e)
            {
            }
            return false;
        }// end function

        public function testFlyStraight(param1, param2)
        {
            var sp:* = param1;
            var ep:* = param2;
            try
            {
                if (this.getPoint(sp, ep, 1))
                {
                    return true;
                }
            }
            catch (e)
            {
            }
            return false;
        }// end function

        private function inRange(param1:LogicalTile)
        {
            return true;
        }// end function

        private function isStEd(param1:LogicalTile)
        {
            if (param1.terrainwalkable)
            {
                if (param1.x == this.startPoint[0] && param1.y == this.startPoint[1] || param1.x == this.endPoint[0] && param1.y == this.endPoint[1])
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function findSurroundingTiles(param1:LogicalTile) : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_2:* = new Array();
            var _loc_3:* = param1.x;
            var _loc_4:* = param1.y;
            if (param1.jumpTile != null && !param1.jumpTile.isClosed())
            {
                _loc_2.push(param1.jumpTile);
                param1.jumpTile.costDown();
                param1.jumpTile.setClosed();
            }
            if (_loc_3 > 0)
            {
                _loc_9 = this.map[_loc_4][(_loc_3 - 1)];
                if ((this.isStEd(_loc_9) || _loc_9.walkable) && !_loc_9.isClosed() && this.inRange(_loc_9))
                {
                    _loc_2.push(_loc_9);
                    _loc_9.costDown();
                }
            }
            if (_loc_3 < (this.mapW - 1))
            {
                _loc_10 = this.map[_loc_4][_loc_3 - -1];
                if ((this.isStEd(_loc_10) || _loc_10.walkable) && !_loc_10.isClosed() && this.inRange(_loc_10))
                {
                    _loc_2.push(_loc_10);
                    _loc_10.costDown();
                }
            }
            if (_loc_4 < (this.mapH - 1))
            {
                _loc_11 = this.map[_loc_4 - -1][_loc_3];
                if ((this.isStEd(_loc_11) || _loc_11.walkable) && !_loc_11.isClosed() && this.inRange(_loc_11))
                {
                    _loc_2.push(_loc_11);
                    _loc_11.costDown();
                }
            }
            if (_loc_4 > 0)
            {
                _loc_12 = this.map[(_loc_4 - 1)][_loc_3];
                if ((this.isStEd(_loc_12) || _loc_12.walkable) && !_loc_12.isClosed() && this.inRange(_loc_12))
                {
                    _loc_2.push(_loc_12);
                    _loc_12.costDown();
                }
            }
            if (this.clippingMode == "semi")
            {
                if (_loc_3 > 0 && _loc_4 > 0)
                {
                    _loc_5 = this.map[(_loc_4 - 1)][(_loc_3 - 1)];
                    if ((this.isStEd(_loc_5) || _loc_5.walkable) && !_loc_5.isClosed() && (this.isStEd(_loc_12) || _loc_12.walkable) && (this.isStEd(_loc_9) || _loc_9.walkable) && this.inRange(_loc_5))
                    {
                        _loc_2.push(_loc_5);
                        _loc_5.costUp();
                    }
                }
                if (_loc_3 > 0 && _loc_4 < (this.mapH - 1))
                {
                    _loc_8 = this.map[_loc_4 - -1][(_loc_3 - 1)];
                    if ((this.isStEd(_loc_8) || _loc_8.walkable) && !_loc_8.isClosed() && (this.isStEd(_loc_11) || _loc_11.walkable) && (this.isStEd(_loc_9) || _loc_9.walkable) && this.inRange(_loc_8))
                    {
                        _loc_2.push(_loc_8);
                        _loc_8.costUp();
                    }
                }
                if (_loc_3 < (this.mapW - 1) && _loc_4 > 0)
                {
                    _loc_6 = this.map[(_loc_4 - 1)][_loc_3 - -1];
                    if ((this.isStEd(_loc_6) || _loc_6.walkable) && !_loc_6.isClosed() && (this.isStEd(_loc_12) || _loc_12.walkable) && (this.isStEd(_loc_10) || _loc_10.walkable) && this.inRange(_loc_6))
                    {
                        _loc_2.push(_loc_6);
                        _loc_6.costUp();
                    }
                }
                if (_loc_3 < (this.mapW - 1) && _loc_4 < (this.mapH - 1))
                {
                    _loc_7 = this.map[_loc_4 - -1][_loc_3 - -1];
                    if ((this.isStEd(_loc_7) || _loc_7.walkable) && !_loc_7.isClosed() && (this.isStEd(_loc_11) || _loc_11.walkable) && (this.isStEd(_loc_10) || _loc_10.walkable) && this.inRange(_loc_7))
                    {
                        _loc_2.push(_loc_7);
                        _loc_7.costUp();
                    }
                }
            }
            else if (this.clippingMode == "full")
            {
                _loc_5 = this.map[(_loc_4 - 1)][(_loc_3 - 1)];
                _loc_6 = this.map[(_loc_4 - 1)][_loc_3 - -1];
                _loc_7 = this.map[_loc_4 - -1][_loc_3 - -1];
                _loc_8 = this.map[_loc_4 - -1][(_loc_3 - 1)];
                if ((this.isStEd(_loc_5) || _loc_5.walkable) && !_loc_5.isClosed() && this.inRange(_loc_5))
                {
                    _loc_2.push(_loc_5);
                    _loc_5.costUp();
                }
                if ((this.isStEd(_loc_6) || _loc_6.walkable) && !_loc_6.isClosed() && this.inRange(_loc_6))
                {
                    _loc_2.push(_loc_6);
                    _loc_6.costUp();
                }
                if ((this.isStEd(_loc_7) || _loc_7.walkable) && !_loc_7.isClosed() && this.inRange(_loc_7))
                {
                    _loc_2.push(_loc_7);
                    _loc_7.costUp();
                }
                if ((this.isStEd(_loc_8) || _loc_8.walkable) && !_loc_8.isClosed() && this.inRange(_loc_8))
                {
                    _loc_2.push(_loc_8);
                    _loc_8.costUp();
                }
            }
            return _loc_2;
        }// end function

        private function ready() : Boolean
        {
            if (this.map.length == 0)
            {
                return false;
            }
            var _loc_1:* = this.startPoint[0];
            if (_loc_1 != this.mf(this.startPoint[0]) || this.startPoint[1] != this.mf(this.startPoint[1]))
            {
                return false;
            }
            if (this.endPoint[0] != this.mf(this.endPoint[0]) || this.endPoint[1] != this.mf(this.endPoint[1]))
            {
                return false;
            }
            if (this.startPoint[0] < 0 || this.startPoint[0] >= this.mapW)
            {
                return false;
            }
            if (this.startPoint[1] < 0 || this.startPoint[1] >= this.mapH)
            {
                return false;
            }
            if (this.endPoint[0] < 0 || this.endPoint[0] >= this.mapW)
            {
                return false;
            }
            if (this.endPoint[1] < 0 || this.endPoint[1] >= this.mapH)
            {
                return false;
            }
            var _loc_2:* = this.map[this.endPoint[1]][this.endPoint[0]];
            if (!_loc_2.terrainwalkable)
            {
                return false;
            }
            return true;
        }// end function

        public function setCost(param1:Number, param2:Number, param3:Number) : void
        {
            this.map[param2][param1].setCost(param3);
            return;
        }// end function

        public function setWalkable(param1:Number, param2:Number, param3:Boolean) : void
        {
            this.map[param2][param1].setWalkable(param3);
            return;
        }// end function

        public function toggleWalkable(param1:Number, param2:Number) : void
        {
            this.map[param2][param1].toggleWalkable();
            return;
        }// end function

        private function openMap()
        {
            var _loc_2:* = NaN;
            var _loc_1:* = this.mapH;
            while (_loc_1-- > 0)
            {
                
                _loc_2 = this.mapW;
                while (_loc_2-- > 0)
                {
                    
                    this.map[_loc_1][_loc_2].reset();
                }
            }
            return;
        }// end function

        public function setStandardCost(param1:Number) : void
        {
            Astar.standardCost = param1;
            return;
        }// end function

        public function setDiagonalCost(param1:Number) : void
        {
            Astar.diagonalCost = param1;
            return;
        }// end function

        private function CanMove(param1, param2, param3 = 0)
        {
            var _loc_4:* = this.map[param2][param1];
            if (this.map[param2][param1] != null)
            {
                if (param3 == 0)
                {
                    if (_loc_4.walkable)
                    {
                        return true;
                    }
                    return false;
                }
                else if (param3 == 1)
                {
                    if (_loc_4.parentWalkable < 1)
                    {
                        return false;
                    }
                    return true;
                }
            }
            else
            {
                return false;
            }
            return;
        }// end function

        private function getPoint(param1, param2, param3 = 0) : Boolean
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_4:* = param1;
            var _loc_5:* = param2;
            var _loc_12:* = 0;
            _loc_8 = _loc_5.x - _loc_4.x;
            _loc_9 = _loc_5.y - _loc_4.y;
            _loc_10 = 1 * _loc_9 / _loc_8;
            _loc_6 = _loc_4.x;
            _loc_7 = _loc_4.y;
            if (!this.CanMove(_loc_5.x, _loc_5.y, param3))
            {
                return false;
            }
            if (_loc_8 == 0)
            {
                if (_loc_9 > 0)
                {
                    _loc_7 = _loc_4.y + 1;
                    while (_loc_7 < _loc_5.y)
                    {
                        
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                    return true;
                }
                else if (_loc_9 < 0)
                {
                    _loc_7 = _loc_4.y - 1;
                    while (_loc_7 > _loc_5.y)
                    {
                        
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        _loc_7 = _loc_7 - 1;
                    }
                    return true;
                }
                else
                {
                    return false;
                }
            }
            if (_loc_9 == 0)
            {
                if (_loc_8 > 0)
                {
                    _loc_6 = _loc_4.x + 1;
                    while (_loc_6 < _loc_5.x)
                    {
                        
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                    return true;
                }
                else
                {
                    _loc_6 = _loc_5.x + 1;
                    while (_loc_6 < _loc_4.x)
                    {
                        
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                    return true;
                }
            }
            _loc_10 = 1 * _loc_9 / _loc_8;
            _loc_11 = -0.5;
            _loc_6 = _loc_4.x;
            _loc_7 = _loc_4.y;
            if (Math.abs(_loc_10) < 1)
            {
                if (_loc_8 > 0 && _loc_9 > 0)
                {
                    _loc_12 = 0;
                    while (_loc_12 < _loc_8)
                    {
                        
                        _loc_6 = _loc_6 + 1;
                        _loc_11 = _loc_11 + Math.abs(_loc_10);
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        if (_loc_11 >= 0)
                        {
                            _loc_7 = _loc_7 + 1;
                            _loc_11 = _loc_11 - 1;
                            if (!this.CanMove(_loc_6, _loc_7, param3))
                            {
                                return false;
                            }
                            if (!this.CanMove((_loc_6 - 1), _loc_7, param3))
                            {
                                return false;
                            }
                        }
                        _loc_12 = _loc_12 + 1;
                    }
                    return true;
                }
                if (_loc_8 > 0 && _loc_9 < 0)
                {
                    _loc_12 = 0;
                    while (_loc_12 < _loc_8)
                    {
                        
                        _loc_6 = _loc_6 + 1;
                        _loc_11 = _loc_11 + Math.abs(_loc_10);
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        if (_loc_11 >= 0)
                        {
                            _loc_7 = _loc_7 - 1;
                            _loc_11 = _loc_11 - 1;
                            if (!this.CanMove(_loc_6, _loc_7, param3))
                            {
                                return false;
                            }
                            if (!this.CanMove((_loc_6 - 1), _loc_7, param3))
                            {
                                return false;
                            }
                        }
                        _loc_12 = _loc_12 + 1;
                    }
                    return true;
                }
                if (_loc_8 < 0 && _loc_9 < 0)
                {
                    _loc_12 = 0;
                    while (_loc_12 < -_loc_8)
                    {
                        
                        _loc_6 = _loc_6 - 1;
                        _loc_11 = _loc_11 + Math.abs(_loc_10);
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        if (_loc_11 >= 0)
                        {
                            _loc_7 = _loc_7 - 1;
                            _loc_11 = _loc_11 - 1;
                            if (!this.CanMove(_loc_6, _loc_7, param3))
                            {
                                return false;
                            }
                            if (!this.CanMove((_loc_6 + 1), _loc_7, param3))
                            {
                                return false;
                            }
                        }
                        _loc_12 = _loc_12 + 1;
                    }
                    return true;
                }
                if (_loc_8 < 0 && _loc_9 > 0)
                {
                    _loc_12 = 0;
                    while (_loc_12 >= _loc_8)
                    {
                        
                        _loc_6 = _loc_6 - 1;
                        _loc_11 = _loc_11 + Math.abs(_loc_10);
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        if (_loc_11 >= 0)
                        {
                            _loc_7 = _loc_7 + 1;
                            _loc_11 = _loc_11 - 1;
                            if (!this.CanMove(_loc_6, _loc_7, param3))
                            {
                                return false;
                            }
                            if (!this.CanMove((_loc_6 + 1), _loc_7, param3))
                            {
                                return false;
                            }
                        }
                        _loc_12 = _loc_12 - 1;
                    }
                    return true;
                }
                return false;
            }
            else
            {
                if (_loc_8 > 0 && _loc_9 > 0)
                {
                    _loc_12 = 0;
                    while (_loc_12 < _loc_9)
                    {
                        
                        _loc_7 = _loc_7 + 1;
                        _loc_11 = _loc_11 + 1 / Math.abs(_loc_10);
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        if (_loc_11 >= 0)
                        {
                            _loc_6 = _loc_6 + 1;
                            _loc_11 = _loc_11 - 1;
                            if (!this.CanMove(_loc_6, _loc_7, param3))
                            {
                                return false;
                            }
                            if (!this.CanMove(_loc_6, (_loc_7 - 1), param3))
                            {
                                return false;
                            }
                        }
                        _loc_12 = _loc_12 + 1;
                    }
                    return true;
                }
                if (_loc_8 < 0 && _loc_9 < 0)
                {
                    _loc_12 = 0;
                    while (_loc_12 < -_loc_9)
                    {
                        
                        _loc_7 = _loc_7 - 1;
                        _loc_11 = _loc_11 + 1 / Math.abs(_loc_10);
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        if (_loc_11 >= 0)
                        {
                            _loc_6 = _loc_6 - 1;
                            _loc_11 = _loc_11 - 1;
                            if (!this.CanMove(_loc_6, _loc_7, param3))
                            {
                                return false;
                            }
                            if (!this.CanMove(_loc_6, (_loc_7 + 1), param3))
                            {
                                return false;
                            }
                        }
                        _loc_12 = _loc_12 + 1;
                    }
                    return true;
                }
                if (_loc_8 > 0 && _loc_9 < 0)
                {
                    _loc_12 = 0;
                    while (_loc_12 < -_loc_9)
                    {
                        
                        _loc_7 = _loc_7 - 1;
                        _loc_11 = _loc_11 + 1 / Math.abs(_loc_10);
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        if (_loc_11 >= 0)
                        {
                            _loc_6 = _loc_6 + 1;
                            _loc_11 = _loc_11 - 1;
                            if (!this.CanMove(_loc_6, _loc_7, param3))
                            {
                                return false;
                            }
                            if (!this.CanMove(_loc_6, (_loc_7 + 1), param3))
                            {
                                return false;
                            }
                        }
                        _loc_12 = _loc_12 + 1;
                    }
                    return true;
                }
                if (_loc_8 < 0 && _loc_9 > 0)
                {
                    _loc_12 = 0;
                    while (_loc_12 < _loc_9)
                    {
                        
                        _loc_7 = _loc_7 + 1;
                        _loc_11 = _loc_11 + 1 / Math.abs(_loc_10);
                        if (!this.CanMove(_loc_6, _loc_7, param3))
                        {
                            return false;
                        }
                        if (_loc_11 >= 0)
                        {
                            _loc_6 = _loc_6 - 1;
                            _loc_11 = _loc_11 - 1;
                            if (!this.CanMove(_loc_6, _loc_7, param3))
                            {
                                return false;
                            }
                            if (!this.CanMove(_loc_6, (_loc_7 - 1), param3))
                            {
                                return false;
                            }
                        }
                        _loc_12 = _loc_12 + 1;
                    }
                    return true;
                }
                return false;
            }
        }// end function

    }
}
