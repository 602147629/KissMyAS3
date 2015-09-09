package lovefox.astar
{

    public class DistrictAstar extends Object
    {
        private var startPoint:District;
        private var endPoint:District;
        private var map:Array;
        private var heap:BinaryHeap;
        private var mf:Function;
        private static var _range:int = 10000;

        public function DistrictAstar()
        {
            this.map = [];
            this.mf = Math.floor;
            return;
        }// end function

        public function setMap(param1:Array) : void
        {
            this.map = param1;
            return;
        }// end function

        public function setStartPoint(param1) : void
        {
            this.startPoint = param1;
            return;
        }// end function

        public function setEndPoint(param1) : void
        {
            this.endPoint = param1;
            return;
        }// end function

        public function findPath() : Object
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = undefined;
            var _loc_10:* = null;
            this.openMap();
            if (!this.ready())
            {
                return [];
            }
            this.heap = new BinaryHeap();
            var _loc_1:* = false;
            var _loc_2:* = this.startPoint;
            if (_loc_2 == null)
            {
                return [];
            }
            _loc_2.setOpen();
            _loc_2.setG(0);
            _loc_2.setParent(_loc_2);
            this.heap.addToHeap(_loc_2);
            while (this.heap.getLength() > 0 && !_loc_1)
            {
                
                _loc_5 = this.heap.getLowest();
                if (_loc_5 == this.endPoint)
                {
                    _loc_1 = true;
                    break;
                }
                _loc_5.setClosed();
                _loc_6 = this.findSurroundingTiles(_loc_5);
                _loc_7 = _loc_6.length;
                while (_loc_7-- > 0)
                {
                    
                    if (!_loc_6[_loc_7].getOpen())
                    {
                        _loc_6[_loc_7].setOpen();
                        _loc_6[_loc_7].setParent(_loc_5);
                        _loc_6[_loc_7].setG(_loc_5.getG());
                        this.heap.addToHeap(_loc_6[_loc_7]);
                        continue;
                    }
                    _loc_8 = _loc_6[_loc_7].getH() + _loc_5.getG() + _loc_6[_loc_7].getCost();
                    if (_loc_8 < _loc_6[_loc_7].getF())
                    {
                        _loc_9 = _loc_6[_loc_7].id;
                        _loc_6[_loc_7].setParent(_loc_5);
                        _loc_6[_loc_7].setG(_loc_5.getG());
                        this.heap.updateList(this.heap.getPosition(_loc_9));
                    }
                }
            }
            if (!_loc_1)
            {
                return [];
            }
            var _loc_3:* = new Array();
            this.endPoint.notice();
            _loc_3.push(this.endPoint);
            var _loc_4:* = this.endPoint.getParent();
            while (_loc_4 != this.startPoint)
            {
                
                _loc_10 = _loc_4;
                _loc_3.push(_loc_10);
                _loc_10.notice();
                _loc_4 = _loc_10.getParent();
            }
            _loc_3.push(this.startPoint);
            this.startPoint.notice();
            _loc_3.reverse();
            return _loc_3;
        }// end function

        private function findSurroundingTiles(param1:District) : Array
        {
            var _loc_2:* = new Array();
            var _loc_3:* = 0;
            while (_loc_3 < param1.neighbor.length)
            {
                
                if (param1.neighbor[_loc_3] != null)
                {
                    if (!param1.neighbor[_loc_3].d.isClosed())
                    {
                        if (Player.level >= param1.neighbor[_loc_3].lv)
                        {
                            _loc_2.push(param1.neighbor[_loc_3].d);
                        }
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        private function ready() : Boolean
        {
            if (this.map.length == 0)
            {
                return false;
            }
            return true;
        }// end function

        public function setCost(param1, param2:Number) : void
        {
            this.map[param1].setCost(param2);
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
            var _loc_1:* = this.map.length;
            while (_loc_1-- > 0)
            {
                
                this.map[_loc_1].reset();
            }
            return;
        }// end function

        public static function set range(param1)
        {
            _range = param1;
            return;
        }// end function

        public static function get range()
        {
            return _range;
        }// end function

    }
}
