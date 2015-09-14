package battle
{
    import utility.*;

    public class BattleRecoveryBadStatus extends Object
    {
        private var _aStatusId:Array;

        public function BattleRecoveryBadStatus()
        {
            this._aStatusId = [];
            return;
        }// end function

        public function get aStatusId() : Array
        {
            return this._aStatusId.concat();
        }// end function

        public function get bRecovery() : Boolean
        {
            return this._aStatusId.length > 0;
        }// end function

        public function clone() : BattleRecoveryBadStatus
        {
            var _loc_1:* = new BattleRecoveryBadStatus();
            _loc_1._aStatusId = this.aStatusId;
            return _loc_1;
        }// end function

        public function marge(param1:BattleRecoveryBadStatus) : void
        {
            this.addStatusIdArray(param1._aStatusId);
            return;
        }// end function

        public function isStatus(param1:int) : Boolean
        {
            return this._aStatusId.indexOf(param1) >= 0;
        }// end function

        public function addStatusId(param1:int) : void
        {
            ArrayUtil.uniquePushId(this._aStatusId, param1);
            return;
        }// end function

        public function addStatusIdArray(param1:Array) : void
        {
            ArrayUtil.uniquePushIdArray(this._aStatusId, param1);
            return;
        }// end function

    }
}
