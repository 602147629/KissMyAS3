package network
{
    import user.*;

    public class NetTaskDailyMissionReceive extends NetTask
    {

        public function NetTaskDailyMissionReceive(param1:int, param2:Function)
        {
            super(NetId.PROTOCOL_DAILY_MISSION_RECEIVE, param2);
            _param.id = param1;
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
                return true;
            }
            else if (param1.resultCode == NetId.RESULT_ERROR_DAILY_MISSION_RECEIVE_CHANGE_DATE)
            {
                return true;
            }
            return false;
        }// end function

    }
}
