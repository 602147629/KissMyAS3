package subdualPoint
{
    import item.*;
    import resource.*;

    public class SubdualPointData extends Object
    {
        private var _individualPoint:int;
        private var _wholePoint:int;
        private var _aIndividualReward:Array;
        private var _aWholeReward:Array;

        public function SubdualPointData()
        {
            this._individualPoint = 0;
            this._wholePoint = 0;
            this._aIndividualReward = [];
            this._aWholeReward = [];
            return;
        }// end function

        public function get individualPoint() : int
        {
            return this._individualPoint;
        }// end function

        public function get wholePoint() : int
        {
            return this._wholePoint;
        }// end function

        public function get aIndividualReward() : Array
        {
            return this._aIndividualReward;
        }// end function

        public function get aWholeReward() : Array
        {
            return this._aWholeReward;
        }// end function

        public function get bEnable() : Boolean
        {
            return this._aIndividualReward.length > 0 || this._aWholeReward.length > 0;
        }// end function

        public function setRecieve(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._individualPoint = param1.personalPoint;
            this._wholePoint = param1.totalPoint;
            SubdualPointManager.getInstance().individualRewardCount = int(param1.personalPrizeCount);
            SubdualPointManager.getInstance().wholeRewardCount = int(param1.totalPrizeCount);
            this._aIndividualReward = [];
            for each (_loc_2 in param1.personalPointList)
            {
                
                _loc_3 = new SubdualPointRewardData();
                _loc_3.setRecieve(_loc_2);
                this._aIndividualReward.push(_loc_3);
            }
            this._aWholeReward = [];
            for each (_loc_2 in param1.totalPointList)
            {
                
                _loc_3 = new SubdualPointRewardData();
                _loc_3.setRecieve(_loc_2);
                this._aWholeReward.push(_loc_3);
            }
            return;
        }// end function

        public function loadResource() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = this._aIndividualReward.concat(this._aWholeReward);
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = ItemManager.getInstance().getItemPng(_loc_2.category, _loc_2.itemId);
                ResourceManager.getInstance().loadResource(_loc_3);
            }
            return;
        }// end function

    }
}
