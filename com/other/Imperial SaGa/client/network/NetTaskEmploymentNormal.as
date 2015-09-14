package network
{
    import dailyMission.*;
    import user.*;

    public class NetTaskEmploymentNormal extends NetTask
    {
        private var _resourceCost:int;

        public function NetTaskEmploymentNormal(param1:Boolean, param2:Array, param3:int, param4:Function)
        {
            super(NetId.PROTOCOL_EMPLOYMENT_NORMAL, param4);
            _param.bVolunteer = false;
            _param.aMaterial = param2 != null ? (param2) : ([]);
            this._resourceCost = param3;
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
