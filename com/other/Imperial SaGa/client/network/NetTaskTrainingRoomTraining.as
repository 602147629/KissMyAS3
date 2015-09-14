package network
{
    import dailyMission.*;
    import tutorial.*;
    import user.*;

    public class NetTaskTrainingRoomTraining extends NetTask
    {
        private var _trainingType:int;
        private var _resourceCost:int;

        public function NetTaskTrainingRoomTraining(param1:int, param2:int, param3:int, param4:Function)
        {
            super(NetId.PROTOCOL_TRAINING_ROOM_TRAINING, param4);
            _param.uniqueId = param1;
            this._trainingType = param2;
            this._resourceCost = param3;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                TutorialManager.getInstance().ClearNoCost_Training();
                UserDataManager.getInstance().userData.setKumiteResource(UserDataManager.getInstance().userData.kumiteResource - this._resourceCost);
                DailyMissionManager.getInstance().checkReceiveComplete(param1.data.dailyMission);
                return true;
            }
            return false;
        }// end function

    }
}
