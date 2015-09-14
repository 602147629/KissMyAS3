package network
{
    import quest.*;
    import user.*;
    import utility.*;

    public class NetTaskQuestStart extends NetTask
    {

        public function NetTaskQuestStart(param1:int, param2:int, param3:uint, param4:Array, param5:Boolean, param6:Function)
        {
            super(NetId.PROTOCOL_QUEST_START, param6);
            _param.questNo = param1;
            _param.difficulty = param2;
            _param.eventId = param3;
            _param.aUseItemId = param4;
            _param.bFreeAssault = param5 ? (1) : (0);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                QuestManager.getInstance().setReceiveQuestStart(param1.data);
                if (_param.bFreeAssault)
                {
                    UserDataManager.getInstance().userData.setLastAssaultTime(TimeClock.getNowTime());
                }
                return true;
            }
            if (param1.resultCode == NetId.RESULT_ERROR_QUEST_START_INVALID_DAILY_QUEST)
            {
                return true;
            }
            return false;
        }// end function

    }
}
