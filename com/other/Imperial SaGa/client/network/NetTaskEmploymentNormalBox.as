package network
{
    import dailyMission.*;
    import user.*;

    public class NetTaskEmploymentNormalBox extends NetTask
    {
        private var _resourceCost:int;

        public function NetTaskEmploymentNormalBox(param1:int, param2:int, param3:Function)
        {
            super(NetId.PROTOCOL_EMPLOYMENT_NORMAL_BOX, param3);
            _param.drawNum = param1;
            this._resourceCost = param2;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                UserDataManager.getInstance().userData.setGachaResource(UserDataManager.getInstance().userData.gachaResource - this._resourceCost);
                if (param1.data.getItemInfo)
                {
                    UserDataManager.getInstance().userData.setGetItemInfo(param1.data.getItemInfo);
                }
                DailyMissionManager.getInstance().checkReceiveComplete(param1.data.dailyMission);
                return true;
            }
            return false;
        }// end function

    }
}
