package dailyMission
{
    import item.*;
    import message.*;

    public class DailyMissionData extends Object
    {
        private var _id:int;
        private var _status:int;
        private var _missionName:String;
        private var _type:int;
        private var _rank:int;
        private var _progressNum:int;
        private var _progressMax:int;
        private var _aPrize:Array;
        private var _rewardText:String;
        private static const _STATUS_UNATTAINED:int = 0;
        private static const _STATUS_ACHIEVED:int = 1;
        private static const _STATUS_RECEIPT:int = 2;

        public function DailyMissionData()
        {
            this._id = Constant.EMPTY_ID;
            this._status = _STATUS_UNATTAINED;
            this._missionName = "";
            this._type = 0;
            this._rank = 0;
            this._progressNum = 0;
            this._progressMax = 0;
            this._aPrize = [];
            this._rewardText = "";
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get bAchieved() : Boolean
        {
            return this._status == _STATUS_ACHIEVED;
        }// end function

        public function get bGet() : Boolean
        {
            return this._status == _STATUS_RECEIPT;
        }// end function

        public function get missionName() : String
        {
            return this._missionName;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function get rank() : int
        {
            return this._rank;
        }// end function

        public function get progressNum() : int
        {
            return this._progressNum;
        }// end function

        public function get progressMax() : int
        {
            return this._progressMax;
        }// end function

        public function get progressRate() : int
        {
            var _loc_1:* = 0;
            if (this._progressMax)
            {
                _loc_1 = 100 * this._progressNum / this._progressMax;
            }
            return _loc_1;
        }// end function

        public function get aPrize() : Array
        {
            return this._aPrize;
        }// end function

        public function get rewardText() : String
        {
            return this._rewardText;
        }// end function

        public function setReceive(param1:Object) : void
        {
            this._id = param1.id;
            this._status = param1.status;
            this._missionName = param1.name;
            this._type = param1.type;
            this._rank = param1.rank;
            this._progressNum = param1.progressNum;
            this._progressMax = param1.progressMax;
            var _loc_2:* = new Prize();
            _loc_2.setReceive(param1.aPrize);
            this._aPrize.push(_loc_2);
            this._rewardText = this.getRewardText();
            return;
        }// end function

        public function changeStatusReceipt() : void
        {
            this._status = _STATUS_RECEIPT;
            return;
        }// end function

        private function getRewardText() : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = "";
            var _loc_2:* = 0;
            while (_loc_2 < this._aPrize.length)
            {
                
                _loc_3 = this._aPrize[_loc_2];
                _loc_4 = ItemManager.getInstance().getItemName(_loc_3.category, _loc_3.itemId);
                if (_loc_2 == 0)
                {
                    _loc_1 = _loc_1 + TextControl.formatIdText(MessageId.DAILY_MISSION_REWARD_TEXT, _loc_4, _loc_3.num);
                }
                else
                {
                    _loc_1 = _loc_1 + (" " + TextControl.formatIdText(MessageId.DAILY_MISSION_GET_REWARD_POPUP_02, _loc_4, _loc_3.num));
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

    }
}
