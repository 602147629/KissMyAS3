package network
{
    import dailyMission.*;

    public class NetTaskBarracksRest extends NetTask
    {

        public function NetTaskBarracksRest(param1:int, param2:int, param3:Function)
        {
            super(NetId.PROTOCOL_BARRACKS_REST, param3);
            _param.uniqueId = param1;
            _param.index = param2;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                param1.data.index = _param.index;
                DailyMissionManager.getInstance().checkReceiveComplete(param1.data.dailyMission);
                return true;
            }
            return false;
        }// end function

    }
}
