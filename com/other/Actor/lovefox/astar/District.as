package lovefox.astar
{
    import flash.events.*;

    public class District extends EventDispatcher
    {
        private var inOpen:Boolean = false;
        private var closed:Boolean = false;
        public var parent:District;
        private var gUp:Boolean = false;
        private var h:Number;
        private var g:Number;
        public var cost:Number;
        public var x:Number;
        public var y:Number;
        public var id:Number;
        public var neighbor:Array;
        public static var count:Number = 0;
        private static var ids:Number = 0;

        public function District(param1, param2)
        {
            this.cost = Astar.standardCost;
            this.neighbor = [];
            this.id = param1;
            this.cost = param2;
            return;
        }// end function

        public function setNeighbor(param1, param2:int = 0) : void
        {
            var _loc_3:* = undefined;
            _loc_3 = 0;
            while (_loc_3 < this.neighbor.length)
            {
                
                if (this.neighbor[_loc_3] == param1)
                {
                    return;
                }
                _loc_3 = _loc_3 + 1;
            }
            this.neighbor.push({d:param1, lv:param2});
            return;
        }// end function

        public function setOpen() : void
        {
            this.inOpen = true;
            this.closed = false;
            return;
        }// end function

        public function setClosed() : void
        {
            this.inOpen = false;
            this.closed = true;
            return;
        }// end function

        public function isClosed() : Boolean
        {
            return this.closed;
        }// end function

        public function getOpen() : Boolean
        {
            return this.inOpen;
        }// end function

        public function setParent(param1:District) : void
        {
            this.parent = param1;
            return;
        }// end function

        public function getParent() : District
        {
            return this.parent;
        }// end function

        public function setH(param1:Number, param2:Number) : void
        {
            this.h = Math.abs(param1 - this.x) * Astar.standardCost + Math.abs(param2 - this.y) * Astar.standardCost;
            return;
        }// end function

        public function setG(param1:Number) : void
        {
            this.g = param1 + this.getCost();
            return;
        }// end function

        public function getF() : Number
        {
            return this.getG() + 0;
        }// end function

        public function getH() : Number
        {
            return 0;
        }// end function

        public function setCost(param1:Number) : void
        {
            this.cost = param1;
            return;
        }// end function

        public function getG() : Number
        {
            return this.g;
        }// end function

        public function getCost() : Number
        {
            return this.cost * (Number(this.gUp) ? (Astar.diagonalCost) : (Astar.standardCost));
        }// end function

        public function reset() : void
        {
            var _loc_1:* = false;
            this.gUp = false;
            this.closed = _loc_1;
            this.inOpen = _loc_1;
            this.parent = null;
            var _loc_1:* = 0;
            this.g = 0;
            this.h = _loc_1;
            return;
        }// end function

        public function costUp() : void
        {
            this.gUp = true;
            return;
        }// end function

        public function costDown() : void
        {
            this.gUp = false;
            return;
        }// end function

        public function notice() : void
        {
            return;
        }// end function

    }
}
