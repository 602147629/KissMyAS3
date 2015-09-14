package network
{
    import dailyMission.*;
    import tutorial.*;
    import user.*;

    public class NetTaskTrainingRoomKumite extends NetTask
    {
        private var _resourceCost:int;

        public function NetTaskTrainingRoomKumite(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function)
        {
            super(NetId.PROTOCOL_TRAINING_ROOM_KUMITE, param6);
            _param.uniqueId = param1;
            _param.skillId = param2;
            _param.kumiteType = param3;
            _param.guestNo = param4;
            this._resourceCost = param5;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                TutorialManager.getInstance().ClearNoCost_Kumite();
                UserDataManager.getInstance().userData.setKumiteResource(UserDataManager.getInstance().userData.kumiteResource - this._resourceCost);
                DailyMissionManager.getInstance().checkReceiveComplete(param1.data.dailyMission);
                return true;
            }
            return false;
        }// end function

    }
}
