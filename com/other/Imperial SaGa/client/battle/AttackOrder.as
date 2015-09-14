package battle
{

    public class AttackOrder extends Object
    {
        private var _questUniqueId:int;
        private var _speed:Number;
        private var _priority:int;
        private var _changeOrder:int;
        public static const PRIORITY_FAST:int = 2;
        public static const PRIORITY_NORMAL:int = 1;
        public static const PRIORITY_LAST:int = 0;

        public function AttackOrder()
        {
            this._priority = PRIORITY_NORMAL;
            this._changeOrder = 0;
            return;
        }// end function

        public function get questUniqueId() : int
        {
            return this._questUniqueId;
        }// end function

        public function set questUniqueId(param1:int) : void
        {
            this._questUniqueId = param1;
            return;
        }// end function

        public function get speed() : Number
        {
            return this._speed;
        }// end function

        public function set speed(param1:Number) : void
        {
            this._speed = param1;
            return;
        }// end function

        public function get priority() : int
        {
            return this._priority;
        }// end function

        public function set priority(param1:int) : void
        {
            this._priority = param1;
            return;
        }// end function

        public function get changeOrder() : int
        {
            return this._changeOrder;
        }// end function

        public function set changeOrder(param1:int) : void
        {
            this._changeOrder = param1;
            return;
        }// end function

        public function toString() : String
        {
            return "id->" + this._questUniqueId + " speed->" + this._speed + " priority->" + this._priority + ", ";
        }// end function

    }
}
