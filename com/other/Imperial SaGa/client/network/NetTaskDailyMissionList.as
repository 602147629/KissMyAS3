package network
{
    import dailyMission.*;

    public class NetTaskDailyMissionList extends NetTask
    {

        public function NetTaskDailyMissionList(param1:Function)
        {
            super(NetId.PROTOCOL_DAILY_MISSION_LIST, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                DailyMissionManager.getInstance().setReceive(param1.data);
                return true;
            }
            return false;
        }// end function

    }
}
