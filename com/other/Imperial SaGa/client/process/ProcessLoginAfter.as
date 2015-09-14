package process
{
    import item.*;
    import network.*;
    import player.*;
    import quest.*;
    import resource.*;
    import tutorial.*;
    import user.*;

    public class ProcessLoginAfter extends ProcessBase
    {
        private var _userData:UserDataPersonal;
        private var _bConnecting:Boolean;

        public function ProcessLoginAfter()
        {
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            var _loc_1:* = ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Topbar.swf", this.cbTopBarLoadComplete);
            _loc_1.bRemoveLock = true;
            _bResourceLoadWait = true;
            this._userData = UserDataManager.getInstance().userData;
            this._bConnecting = false;
            return;
        }// end function

        private function cbTopBarLoadComplete() : void
        {
            if (UserDataManager.getInstance().userData.statusType != CommonConstant.USER_STATE_CREATE && UserDataManager.getInstance().userData.statusType != CommonConstant.USER_STATE_OPENING)
            {
                Main.GetProcess().createTopBar();
            }
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return;
            }
            bResourceLoadWait = false;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            if (this._bConnecting)
            {
                return;
            }
            if (UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_CREATE)
            {
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_TITLE);
                return;
            }
            if (UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_OPENING)
            {
                Main.GetProcess().setBackGroundVisible(false);
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_OPENING);
                return;
            }
            if (UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_TUTORIAL)
            {
                if (!TutorialManager.getInstance().isGotAfterTutorialFrontMember())
                {
                    this.resetTutorialMember();
                    return;
                }
                QuestManager.getInstance().setQuestNo(1, 0);
                QuestManager.getInstance().setDifficulty(CommonConstant.QUEST_OPERATION_EASY);
                QuestManager.getInstance().setUseItem([PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT], null);
                Main.GetProcess().topBar.open();
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_QUEST);
                return;
            }
            else if (UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT)
            {
                if (!TutorialManager.getInstance().isGotAfterTutorialFrontMember())
                {
                    this.resetTutorialMember();
                    return;
                }
                Main.GetProcess().topBar.open();
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_QUEST_SELECT);
                return;
            }
            else if (UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_TUTORIAL_2)
            {
                if (!TutorialManager.getInstance().isGotAfterTutorialFrontMember())
                {
                    this.resetTutorialMember();
                    return;
                }
                QuestManager.getInstance().setQuestNo(2, 0);
                QuestManager.getInstance().setDifficulty(CommonConstant.QUEST_OPERATION_EASY);
                QuestManager.getInstance().setUseItem([PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT], null);
                Main.GetProcess().topBar.open();
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_QUEST);
                return;
            }
            else if (UserDataManager.getInstance().userData.statusType == CommonConstant.USER_STATE_TUTORIAL_3)
            {
                TutorialManager.getInstance().bTutorialProtocol = true;
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
                return;
            }
            Main.GetProcess().SetProcessId(ProcessMain.PROCESS_TITLE);
            return;
        }// end function

        private function resetTutorialMember() : void
        {
            NetManager.getInstance().request(new NetTaskGetTutorialUnit(function (param1:NetResult) : void
            {
                var _loc_3:* = undefined;
                var _loc_4:* = undefined;
                TutorialManager.getInstance().aAfterTutorialFrontMemberUniqueId = _userData.aFormationPlayerUniqueId;
                TutorialManager.getInstance().afterTutorialFormationId = _userData.formationId;
                var _loc_2:* = [];
                for each (_loc_3 in param1.data.aPlayer)
                {
                    
                    _loc_4 = new PlayerPersonal();
                    _loc_4.setParameter(_loc_3);
                    _userData.addPlayerPersonal(_loc_4);
                    _loc_2.push(_loc_4.uniqueId);
                }
                _userData.setFormationPlayer(_loc_2);
                _userData.formationId = 0;
                _bConnecting = false;
                return;
            }// end function
            ));
            this._bConnecting = true;
            return;
        }// end function

    }
}
