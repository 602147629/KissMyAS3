package lovefox.astar
{

    class BinaryHeap extends Object
    {
        private var heap:Array;

        function BinaryHeap()
        {
            this.heap = new Array(null);
            return;
        }// end function

        public function addToHeap(param1) : void
        {
            var _loc_4:* = undefined;
            this.heap.push(param1);
            var _loc_2:* = this.heap.length - 1;
            var _loc_3:* = Math.floor(_loc_2 / 2);
            while (_loc_2 != 1)
            {
                
                if (this.heap[_loc_2].getF() <= this.heap[Math.floor(_loc_2 / 2)].getF())
                {
                    _loc_4 = this.heap[Math.floor(_loc_2 / 2)];
                    this.heap[Math.floor(_loc_2 / 2)] = this.heap[_loc_2];
                    this.heap[_loc_2] = _loc_4;
                    _loc_2 = Math.floor(_loc_2 / 2);
                    continue;
                }
                break;
            }
            return;
        }// end function

        public function getLowest()
        {
            var _loc_2:* = NaN;
            var _loc_4:* = undefined;
            var _loc_1:* = 1;
            var _loc_3:* = this.heap[1];
            if (this.heap.length == 2)
            {
                this.heap.pop();
            }
            else
            {
                this.heap[1] = this.heap.pop();
            }
            while (true)
            {
                
                _loc_2 = _loc_1;
                if (_loc_1 * 2 - -1 <= (this.heap.length - 1))
                {
                    if (this.heap[_loc_2].getF() >= this.heap[_loc_2 * 2].getF())
                    {
                        _loc_1 = 2 * _loc_2;
                    }
                    if (this.heap[_loc_1].getF() >= this.heap[_loc_2 * 2 - -1].getF())
                    {
                        _loc_1 = 2 * _loc_2 - -1;
                    }
                }
                else if (2 * _loc_2 <= (this.heap.length - 1))
                {
                    if (this.heap[_loc_2].getF() >= this.heap[2 * _loc_2].getF())
                    {
                        _loc_1 = 2 * _loc_2;
                    }
                }
                if (_loc_2 != _loc_1)
                {
                    _loc_4 = this.heap[_loc_2];
                    this.heap[_loc_2] = this.heap[_loc_1];
                    this.heap[_loc_1] = _loc_4;
                    continue;
                }
                return _loc_3;
            }
            return null;
        }// end function

        public function getLength() : Number
        {
            return (this.heap.length - 1);
        }// end function

        public function getPosition(param1)
        {
            var _loc_2:* = this.heap.length;
            while (_loc_2-- > 0)
            {
                
                if (this.heap[_loc_2].id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function updateList(param1) : void
        {
            var _loc_4:* = undefined;
            var _loc_2:* = param1;
            var _loc_3:* = Math.floor(_loc_2 / 2);
            while (_loc_2 != 1)
            {
                
                if (this.heap[_loc_2].getF() <= this.heap[Math.floor(_loc_2 / 2)].getF())
                {
                    _loc_4 = this.heap[Math.floor(_loc_2 / 2)];
                    this.heap[Math.floor(_loc_2 / 2)] = this.heap[_loc_2];
                    this.heap[_loc_2] = _loc_4;
                    _loc_2 = Math.floor(_loc_2 / 2);
                    continue;
                }
                break;
            }
            return;
        }// end function

    }
}
