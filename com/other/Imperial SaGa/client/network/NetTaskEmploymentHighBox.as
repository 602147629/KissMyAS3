package network
{
    import dailyMission.*;
    import user.*;

    public class NetTaskEmploymentHighBox extends NetTask
    {
        private var _price:int;

        public function NetTaskEmploymentHighBox(param1:int, param2:Function)
        {
            super(NetId.PROTOCOL_EMPLOYMENT_HIGH_BOX, param2);
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

    }
}
