package network
{
    import dailyMission.*;
    import player.*;
    import user.*;

    public class NetTaskEmploymentHigh extends NetTask
    {
        private var _price:int;

        public function NetTaskEmploymentHigh(param1:int, param2:Function)
        {
            super(NetId.PROTOCOL_EMPLOYMENT_HIGH, param2);
            this._price = param1;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                if (param1.data.getItemInfo)
                {
                    UserDataManager.getInstance().userData.setGetItemInfo(param1.data.getItemInfo);
                }
                DailyMissionManager.getInstance().checkReceiveComplete(param1.data.dailyMission);
                return true;
            }
            return false;
        }// end function

        override public function tutorialProtocol(param1:NetResult) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = UserDataManager.getInstance().userData;
            param1.data.employmentLotteryData = {playerId:CommonConstant.INIT_PLAYER_ID_5, aOutPlayerId:[PlayerId.ID_Gray_RS1_RR, PlayerId.ID_Claudia_RS1_RR]};
            param1.data.crownData = {};
            param1.data.crownData.free = Math.max(0, _loc_2.getCrownTotal().free - this._price);
            param1.data.crownData.paid = _loc_2.getCrownTotal().paid;
            var _loc_3:* = _loc_2.aFormationPlayerUniqueId;
            for each (_loc_4 in _loc_2.aPlayerPersonal)
            {
                
                if (_loc_4.playerId == CommonConstant.INIT_PLAYER_ID_5 && _loc_3.indexOf(_loc_4.uniqueId) == -1)
                {
                    _loc_4.resetSp();
                    break;
                }
            }
            return;
        }// end function

    }
}
