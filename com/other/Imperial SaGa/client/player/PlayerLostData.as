package player
{

    public class PlayerLostData extends Object
    {
        private var _uniqueId:uint;
        private var _playerId:int;

        public function PlayerLostData(param1:uint, param2:int)
        {
            this._uniqueId = param1;
            this._playerId = param2;
            return;
        }// end function

        public function get uniqueId() : uint
        {
            return this._uniqueId;
        }// end function

        public function get playerId() : int
        {
            return this._playerId;
        }// end function

    }
}
