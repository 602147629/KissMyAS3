package battle
{

    public class BattleBadStatusData extends Object
    {
        private var _id:int;
        private var _turn:int;

        public function BattleBadStatusData(param1:int, param2:int = 0)
        {
            this._id = param1;
            this._turn = param2;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get turn() : int
        {
            return this._turn;
        }// end function

        public function trunDecrease() : void
        {
            if (this._turn > 0)
            {
                var _loc_1:* = this;
                var _loc_2:* = this._turn - 1;
                _loc_1._turn = _loc_2;
            }
            return;
        }// end function

        public function clone() : BattleBadStatusData
        {
            return new BattleBadStatusData(this._id, this._turn);
        }// end function

    }
}
