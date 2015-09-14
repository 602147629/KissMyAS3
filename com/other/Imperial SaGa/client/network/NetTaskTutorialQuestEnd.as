package network
{
    import quest.*;
    import user.*;

    public class NetTaskTutorialQuestEnd extends NetTask
    {

        public function NetTaskTutorialQuestEnd(param1:Function)
        {
            super(NetId.PROTOCOL_TUTORIAL_QUEST_END, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = new Object();
                _loc_2.resultMessageType = 1;
                _loc_2.aRoadRemuneration = param1.data.aRoadRemuneration;
                _loc_2.aClearRemuneration = param1.data.aClearRemuneration;
                _loc_2.aFirstRemuneration = param1.data.aFirstRemuneration;
                _loc_2.aFirstClearRemuneration = param1.data.aFirstClearRemuneration;
                _loc_2.achievementRate = 100;
                _loc_2.aQuestHistory = null;
                _loc_2.resultType = CommonConstant.QUEST_RESULT_TYPE_SUCCESS;
                _loc_2.totalExp = 0;
                _loc_2.statusType = CommonConstant.USER_STATE_TUTORIAL;
                if (param1.data.getItemInfo)
                {
                    UserDataManager.getInstance().userData.setGetItemInfo(param1.data.getItemInfo);
                    _loc_2.getItemInfo = param1.data.getItemInfo;
                }
                QuestManager.getInstance().setReceiveQuestResult(_loc_2);
                return true;
            }
            return false;
        }// end function

    }
}
