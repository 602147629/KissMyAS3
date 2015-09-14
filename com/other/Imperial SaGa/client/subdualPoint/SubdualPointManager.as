package subdualPoint
{

    public class SubdualPointManager extends Object
    {
        private var _individualRewardCount:int;
        private var _wholeRewardCount:int;
        private var _aIndividualReceived:Array;
        private var _aWholeReceived:Array;
        private static var _instance:SubdualPointManager = null;

        public function SubdualPointManager()
        {
            this._individualRewardCount = 0;
            this._wholeRewardCount = 0;
            this._aIndividualReceived = [];
            this._aWholeReceived = [];
            return;
        }// end function

        public function get individualRewardCount() : int
        {
            return this._individualRewardCount;
        }// end function

        public function set individualRewardCount(param1:int) : void
        {
            this._individualRewardCount = param1;
            return;
        }// end function

        public function get bIndividualReward() : Boolean
        {
            return this._individualRewardCount > 0;
        }// end function

        public function get wholeRewardCount() : int
        {
            return this._wholeRewardCount;
        }// end function

        public function set wholeRewardCount(param1:int) : void
        {
            this._wholeRewardCount = param1;
            return;
        }// end function

        public function get bWholeReward() : Boolean
        {
            return this._wholeRewardCount > 0;
        }// end function

        public function get bAnyReward() : Boolean
        {
            return this.bIndividualReward || this.bWholeReward;
        }// end function

        public function addReceivedReward(param1:int, param2:SubdualPointRewardData) : void
        {
            if (this.checkReceivedReward(param1, param2))
            {
                return;
            }
            var _loc_3:* = param1 == 0 ? (this._aIndividualReceived) : (this._aWholeReceived);
            _loc_3.push(param2);
            return;
        }// end function

        public function checkReceivedReward(param1:int, param2:SubdualPointRewardData) : Boolean
        {
            var _loc_4:* = null;
            var _loc_3:* = param1 == 0 ? (this._aIndividualReceived) : (this._aWholeReceived);
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4.point == param2.point && _loc_4.category == param2.category && _loc_4.itemId == param2.itemId && _loc_4.num == param2.num)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function getInstance() : SubdualPointManager
        {
            if (_instance == null)
            {
                _instance = new SubdualPointManager;
            }
            return _instance;
        }// end function

    }
}
