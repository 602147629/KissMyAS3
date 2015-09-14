package network
{
    import dailyMission.*;
    import develop.*;
    import notice.*;
    import quest.*;
    import subdualPoint.*;
    import user.*;

    public class NetTaskQuestEnd extends NetTask
    {
        private var _resultType:int;

        public function NetTaskQuestEnd(param1:Object, param2:Function)
        {
            super(NetId.PROTOCOL_QUEST_END, param2);
            this._resultType = param1.resultId;
            _param.resultId = param1.resultId;
            _param.aEvent = param1.aEvent;
            _param.aPersonal = param1.aPersonal;
            _param.aBattleResult = param1.aBattleResult;
            _param.totalBattleExp = param1.battleExp;
            _param.totalBattleWin = param1.totalBattleWin;
            _param.totalMassCount = param1.totalMassCount;
            _param.formationData = param1.formationData;
            _param.killCount = param1.killCount;
            _param.aFlag = param1.aFlag;
            _param.aItemData = param1.aItemData;
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = false;
            var _loc_7:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = UserDataManager.getInstance().userData;
                _loc_2.statusType = param1.data.statusType;
                DebugLog.print("statusType:" + _loc_2.statusType);
                QuestManager.getInstance().setReceiveQuestResult(param1.data);
                if (param1.data.progress)
                {
                    _loc_2.setProgress(param1.data.progress);
                }
                else if (param1.data.statusType != CommonConstant.USER_STATE_KEY_QUEST)
                {
                    _loc_2.addProgress();
                }
                if (param1.data.totalExp)
                {
                    _loc_3 = int(param1.data.totalExp);
                    _loc_4 = UserDataManager.getInstance().getEmperorLv();
                    _loc_2.updateExp(_loc_3);
                    _loc_5 = UserDataManager.getInstance().getEmperorLv();
                    if (_loc_4 != _loc_5)
                    {
                        _loc_2.addOwnFormation(param1.data.aNewOwnFormationData);
                        _loc_6 = GetItemInfo.checkFilterWarehouse(param1.data.getItemInfo, CommonConstant.NOTICE_LV_UP_REMUNERATION);
                        for each (_loc_7 in param1.data.aLvUpNotice)
                        {
                            
                            NoticeManager.getInstance().addLvUpNoticeByObject(_loc_7, _loc_6);
                        }
                        if (_loc_4 < _loc_5)
                        {
                            _loc_2.setFreeHealingLvUpCount(_loc_5 - _loc_4);
                        }
                    }
                }
                if (param1.data.getItemInfo)
                {
                    UserDataManager.getInstance().userData.setGetItemInfo(param1.data.getItemInfo);
                }
                SubdualPointManager.getInstance().individualRewardCount = int(param1.data.personalPrizeCount);
                SubdualPointManager.getInstance().wholeRewardCount = int(param1.data.totalPrizeCount);
                DailyMissionManager.getInstance().checkReceiveComplete(param1.data.dailyMission);
                return true;
            }
            return false;
        }// end function

    }
}
