package network
{
    import dailyMission.*;
    import home.*;
    import magicLaboratory.*;
    import notice.*;
    import resource.*;
    import script.*;
    import storage.*;
    import subdualPoint.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class NetTaskLogin extends NetTask
    {

        public function NetTaskLogin(param1:Function)
        {
            super(NetId.PROTOCOL_LOGIN, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (param1.resultCode == NetId.RESULT_OK)
            {
                _loc_2 = "";
                Main.GetApplicationData().setGameData(param1.data.gameId, param1.data.worldId);
                Main.GetApplicationData().setTimeToolUrl(param1.data.timeToolUrl);
                if (param1.data.hasOwnProperty("key"))
                {
                    Blowfish.setFixationKey(param1.data.key);
                }
                ResourceManager.getInstance().restorationXmlAll();
                if (NetManager.getInstance().bDummyServer == false)
                {
                    _loc_8 = "";
                    if (param1.data.aVersion.length == 0)
                    {
                        _loc_8 = "\nバージョン情報が送られていません。";
                    }
                    else
                    {
                        _loc_8 = Main.GetApplicationData().checkVersion(param1.data.aVersion);
                    }
                    if (_loc_8 != "")
                    {
                        Assert.print("以下のエラーが発生：" + _loc_8);
                    }
                }
                if (param1.data.hasOwnProperty("sessionId"))
                {
                    Main.GetApplicationData().setSessionId(param1.data.sessionId);
                }
                if (param1.data.hasOwnProperty("epochTime"))
                {
                    Main.GetApplicationData().setServerTime(param1.data.epochTime);
                }
                _loc_3 = UserDataManager.getInstance().userData;
                _loc_3.setChannel(param1.data.channel);
                _loc_3.setUserData(param1.data.userData);
                _loc_3.setOwnFormation(param1.data.aOwnFormationData);
                _loc_3.setFormationPlayer(param1.data.formationData.aPlayerUniqueId);
                _loc_3.setCurrentFormation(param1.data.formationData.id);
                _loc_3.setPlayerPersonal(param1.data.aPlayerPersonal);
                _loc_3.setGrowthCurve(param1.data.aGrowthCurve);
                _loc_3.setClearQuestId(param1.data.aClearQuest);
                _loc_3.setBarracksData(param1.data.aBarracksData);
                _loc_3.setSuccessiveEmperor(param1.data.aEmperorId);
                _loc_3.setOwnEquipItem(param1.data.aOwnItemData);
                _loc_3.setOwnDestinyStone(param1.data.aOwnMaterialData);
                _loc_3.setOwnPaymentItem(param1.data.aOwnPaymentItemData);
                _loc_3.setFreeAssaultNum(param1.data.freeAssaultNum);
                _loc_3.setLastAssaultTime(param1.data.lastAssaultTime);
                _loc_3.setFreeHealingNum(param1.data.freeHealingNum);
                _loc_3.setLastFreeHealingTime(param1.data.lastFreeHealingTime);
                _loc_3.setGoldInsignia(param1.data.gold_insignia);
                _loc_3.setSilverInsignia(param1.data.silver_insignia);
                TutorialManager.getInstance().setFacilityTutorialEndServerFlag(param1.data.userData.tutorialFlag);
                for each (_loc_4 in param1.data.aEventFlag)
                {
                    
                    _loc_9 = new ScriptParamFlag();
                    _loc_9.setParam(_loc_4, true);
                    ScriptManager.getInstance().setFlag(_loc_9);
                }
                for each (_loc_5 in param1.data.notice.aInstitutionNotice)
                {
                    
                    NoticeManager.getInstance().addMiniNoticeByObject(_loc_5);
                }
                for each (_loc_5 in param1.data.notice.aAnnounce)
                {
                    
                    NoticeManager.getInstance().addManagementNoticeByObject(_loc_5);
                }
                NoticeManager.getInstance().setManagementNoticeAutoDisp(param1.data.notice.announceDisp == 1);
                for each (_loc_6 in param1.data.notice.aLostPlayer)
                {
                    
                    NoticeManager.getInstance().addCharacterLost(_loc_6);
                }
                _loc_7 = NoticeManager.getInstance().getLvUpCount();
                _loc_3.setFreeHealingLvUpCount(_loc_7);
                if (_loc_7 > 0)
                {
                    _loc_3.advanceLastFreeHealingTime(_loc_7);
                }
                _loc_3.checkInvalidFacilityNotice();
                Main.GetApplicationData().bLogin = true;
                SubdualPointManager.getInstance().individualRewardCount = int(param1.data.personalPrizeCount);
                SubdualPointManager.getInstance().wholeRewardCount = int(param1.data.totalPrizeCount);
                DailyMissionManager.getInstance().checkReceiveComplete(param1.data.dailyMission);
                StorageManager.getInstance().setGiftCount(param1.data.warehouseGiftCount);
                StorageManager.getInstance().setUnlimitedGiftCount(param1.data.warehouseUnlimitedCount);
                AnnouncementCheck.setInitGiftCount(StorageManager.getInstance().warehouseTotalGiftCount());
                StorageManager.getInstance().setWarehouseGiftDleted(param1.data.bWarehouseGiftDleted);
                if (param1.data.hasOwnProperty("loginBonusGetTime"))
                {
                    Main.GetApplicationData().loginBonusGetTime = param1.data.loginBonusGetTime;
                }
                else
                {
                    Main.GetApplicationData().loginBonusGetTime = TimeClock.getNowTime() + 1000000;
                }
                MagicLabolatoryManager.getInstance().developCompleteTime = param1.data.userData.magicDevelopEnd;
                return true;
            }
            return false;
        }// end function

    }
}
